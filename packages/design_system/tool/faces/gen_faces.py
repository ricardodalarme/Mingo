#!/usr/bin/env python3
"""Builds assets/faces.lottie from the seven BaseFace line drawings.

Each face becomes two animations in one dotLottie file:
  <kind>_in    draw-on, plays once
  <kind>_idle  seamless loop (blink, breathing, small accents)
The stroke and fill use the color slot "ink", so the app can recolor at runtime
with setColorSlot('ink', r, g, b).

Run:  python3 tool/gen_faces.py        (needs: pip install svgpathtools)
Preview (optional): python3 tool/gen_faces.py --preview   (needs rlottie-python, pillow)
"""
import json, math, re, sys, zipfile, pathlib
from svgpathtools import parse_path, Line, CubicBezier, QuadraticBezier, Arc

ROOT = pathlib.Path(__file__).resolve().parents[2]
FPS = 30
IN_FRAMES = 30
IDLE_FRAMES = 120
INK = [0.17, 0.13, 0.15, 1]

# kind -> list of (svg path d, stroke width, filled, [roles per subpath])
FACES = {
  "good": [
    ("M11.5 13v3M20.5 13v3", 1.8, False, ["eyeL", "eyeR"]),
    ("M10 20.5c3.2 3.6 8.8 3.6 12 0", 1.8, False, ["mouth"]),
  ],
  "affectionate": [
    ("M11 16.8c-2.6-1.7-3.6-2.9-3.6-4.2 0-1 .8-1.8 1.8-1.8.8 0 1.4.4 1.8 1.1.4-.7 1-1.1 1.8-1.1 1 0 1.8.8 1.8 1.8 0 1.3-1 2.5-3.6 4.2zM21 16.8c-2.6-1.7-3.6-2.9-3.6-4.2 0-1 .8-1.8 1.8-1.8.8 0 1.4.4 1.8 1.1.4-.7 1-1.1 1.8-1.1 1 0 1.8.8 1.8 1.8 0 1.3-1 2.5-3.6 4.2z", 0, True, ["heartL", "heartR"]),
    ("M11.5 21.5c2.6 2.6 6.4 2.6 9 0", 1.8, False, ["mouth"]),
  ],
  "tired": [
    ("M9.5 15c1.2 1.2 3 1.2 4.2 0M18.3 15c1.2 1.2 3 1.2 4.2 0", 1.8, False, ["eyeL", "eyeR"]),
    ("M14 22h4", 1.8, False, ["mouth"]),
    ("M22 6h3.5L22 9.5h3.5", 1.5, False, ["zzz"]),
  ],
  "tense": [
    ("M9.5 11.5l4 1.5M22.5 11.5l-4 1.5", 1.8, False, ["browL", "browR"]),
    ("M12 15.5v2M20 15.5v2", 1.8, False, ["eyeL", "eyeR"]),
    ("M10.5 22.5l2-1.5 1.8 1.5 1.8-1.5 1.8 1.5 1.8-1.5 1.8 1.5", 1.8, False, ["mouth"]),
  ],
  "sad": [
    ("M11.5 13.5v2.6M20.5 13.5v2.6", 1.8, False, ["eyeL", "eyeR"]),
    ("M11.5 23c2.6-2.6 6.4-2.6 9 0", 1.8, False, ["mouth"]),
    ("M8.6 18.5c-.7 1-1 1.7-1 2.2a1 1 0 002 0c0-.5-.3-1.2-1-2.2z", 1.4, False, ["tear"]),
  ],
  "thinking": [
    ("M8 9.5l1.4 2.2M5.8 13l1.6.6M24 9.5l-1.4 2.2M26.2 13l-1.6.6", 1.8, False, ["sparkA", "sparkB", "sparkA", "sparkB"]),
    ("M13 14.5v2.4M19 14.5v2.4", 1.8, False, ["eyeLook", "eyeLook"]),
    ("M13.5 22c1.6 1.3 3.4 1.3 5 0", 1.8, False, ["mouth"]),
    ("M16 17.5l-.8 2.2h1.4", 1.8, False, ["nose"]),
  ],
  "smile": [
    ("M10 14.5c.9-1.4 2.7-1.4 3.6 0M18.4 14.5c.9-1.4 2.7-1.4 3.6 0", 1.8, False, ["eyeSmile", "eyeSmile"]),
    ("M10.5 19.5c2.8 3.6 8.2 3.6 11 0", 1.8, False, ["mouth"]),
    ("M6 9l1.6 1.2M26 9l-1.6 1.2", 1.8, False, ["sparkA", "sparkB"]),
  ],
}

# ---------- svg path -> lottie bezier ----------
def pt(c): return [round(c.real, 4), round(c.imag, 4)]

def to_cubic(seg):
    if isinstance(seg, Line):
        return [(seg.start, seg.start, seg.end, seg.end)]
    if isinstance(seg, QuadraticBezier):
        c1 = seg.start + 2 / 3 * (seg.control - seg.start)
        c2 = seg.end + 2 / 3 * (seg.control - seg.end)
        return [(seg.start, c1, c2, seg.end)]
    if isinstance(seg, CubicBezier):
        return [(seg.start, seg.control1, seg.control2, seg.end)]
    if isinstance(seg, Arc):
        n = max(2, math.ceil(abs(seg.delta) / 90))
        out = []
        for k in range(n):
            a = Arc(seg.point(k / n), seg.radius, seg.rotation, False, seg.sweep, seg.point((k + 1) / n))
            # split the arc by points: approximate each piece with one cubic from tangent estimates
            p0, p1 = seg.point(k / n), seg.point((k + 1) / n)
            t0, t1 = seg.unit_tangent(k / n), seg.unit_tangent((k + 1) / n)
            # handle length for a circular piece
            r = abs(seg.radius.real)
            ang = abs(seg.delta) / n * math.pi / 180
            h = 4 / 3 * math.tan(ang / 4) * r
            out.append((p0, p0 + t0 * h, p1 - t1 * h, p1))
        return out
    raise ValueError(seg)

def subpath_shape(sub):
    verts, ins, outs = [], [], []
    cubics = []
    for seg in sub:
        cubics += to_cubic(seg)
    first = cubics[0][0]
    verts.append(first); ins.append(0j); outs.append(cubics[0][1] - cubics[0][0])
    for idx, (p0, c1, c2, p1) in enumerate(cubics):
        is_last = idx == len(cubics) - 1
        closed = sub.isclosed()
        if is_last and closed:
            ins[0] = c2 - p1
            break
        verts.append(p1)
        ins.append(c2 - p1)
        outs.append((cubics[idx + 1][1] - cubics[idx + 1][0]) if not is_last else 0j)
    return {
        "c": sub.isclosed(),
        "v": [pt(v) for v in verts], "i": [pt(v) for v in ins], "o": [pt(v) for v in outs],
    }

def bbox_center(sub):
    xmin, xmax, ymin, ymax = sub.bbox()
    return [round((xmin + xmax) / 2, 3), round((ymin + ymax) / 2, 3)]

# ---------- keyframes ----------
EASE = {"i": {"x": [0.42], "y": [1]}, "o": {"x": [0.58], "y": [0]}}
def ease(n): return {"i": {"x": [0.42] * n, "y": [1] * n}, "o": {"x": [0.58] * n, "y": [0] * n}}

def prop(frames, values, hold=False):
    """Animated property. values are scalars or lists."""
    vals = [v if isinstance(v, list) else [v] for v in values]
    if len(set(map(tuple, vals))) == 1:
        return {"a": 0, "k": vals[0] if len(vals[0]) > 1 else vals[0][0]}
    ks = []
    for idx, (t, v) in enumerate(zip(frames, vals)):
        k = {"t": t, "s": v}
        if idx < len(frames) - 1:
            if hold:
                k["h"] = 1
            else:
                k.update(ease(len(v)))
        ks.append(k)
    return {"a": 1, "k": ks}

def static(v): return {"a": 0, "k": v}

# ---------- role motion (idle loop, 120 frames) ----------
def idle_motion(role, center):
    cx, cy = center
    T = IDLE_FRAMES
    pos, scale, rot, opa = None, None, None, None
    blink = lambda t: ([0, t, t + 4, t + 8, T], [[100, 100], [100, 100], [100, 8], [100, 100], [100, 100]])
    if role in ("eyeL", "eyeR", "eyeLook"):
        f, v = blink(74 if role != "eyeR" else 75)
        scale = prop(f, v)
    if role == "eyeLook":
        pos = prop([0, 30, 60, 90, T], [[cx, cy], [cx - 0.7, cy], [cx - 0.7, cy], [cx + 0.7, cy], [cx, cy]])
    if role == "eyeSmile":
        pos = prop([0, 60, T], [[cx, cy], [cx, cy - 0.35], [cx, cy]])
    if role in ("heartL", "heartR"):
        off = 0 if role == "heartL" else 6
        scale = prop([0, 10 + off, 22 + off, 34 + off, 60, T], [[100, 100], [100, 100], [114, 114], [100, 100], [100, 100], [100, 100]])
    if role == "mouth":
        scale = prop([0, 50, 70, T], [[100, 100], [100, 100], [104, 104], [100, 100]]) if False else prop([0, 60, T], [[100, 100], [103, 100], [100, 100]])
    if role in ("browL", "browR"):
        s = 1 if role == "browL" else -1
        rot = prop([0, 20, 40, 60, 80, 100, T], [0, 2.5 * s, 0, 2.5 * s, 0, 2.5 * s, 0])
    if role == "zzz":
        pos = prop([0, 70, T], [[cx, cy], [cx + 0.6, cy - 2.4], [cx + 1.2, cy - 4.4]]) if False else prop([0, T], [[cx, cy], [cx, cy]])
        pos = prop([0, 60, T], [[cx, cy], [cx + 0.8, cy - 2.2], [cx, cy]])
        opa = prop([0, 20, 60, 100, T], [[35], [100], [100], [35], [35]])
    if role == "tear":
        pos = prop([0, 40, 90, T], [[cx, cy], [cx, cy], [cx, cy + 6.5], [cx, cy]])
        opa = prop([0, 38, 40, 70, 90, 92, T], [[0], [0], [100], [100], [0], [0], [0]])
    if role in ("sparkA", "sparkB"):
        off = 0 if role == "sparkA" else 30
        opa = prop([0, 15 + off, 45 + off, 75 + off, T + 30], [[100], [30], [100], [30], [100]]) if False else prop([0, 30, 60, 90, T], [[100], [35], [100], [35], [100]] if role == "sparkA" else [[35], [100], [35], [100], [35]])
        scale = prop([0, 30, 60, 90, T], [[100, 100], [92, 92], [100, 100], [92, 92], [100, 100]] if role == "sparkA" else [[92, 92], [100, 100], [92, 92], [100, 100], [92, 92]])
    if role == "nose":
        pos = prop([0, 30, 60, 90, T], [[cx, cy], [cx - 0.4, cy], [cx - 0.4, cy], [cx + 0.4, cy], [cx, cy]])
    return pos, scale, rot, opa

def in_motion(role, center, index):
    cx, cy = center
    d = index * 2  # stagger
    if role.startswith("heart") or role == "tear":
        scale = prop([d, d + 8, d + 14, d + 20], [[0, 0], [118, 118], [96, 96], [100, 100]])
        return None, scale, None, prop([d, d + 4, IN_FRAMES], [[0], [100], [100]])
    return None, None, None, prop([d, d + 4, IN_FRAMES], [[0], [100], [100]])

def trim_in(index):
    d = index * 2
    return {"ty": "tm", "s": static(0), "e": prop([d, d + 16, IN_FRAMES], [0, 100, 100]), "o": static(0), "m": 1, "nm": "Draw on"}

# ---------- layer build ----------
def build_anim(kind, mode):
    total = IN_FRAMES if mode == "in" else IDLE_FRAMES
    layers = []
    # null parent: breathing around the face center
    breathe = {"ty": 3, "ddd": 0, "sr": 1, "ao": 0, "ind": 1, "nm": "Face", "ip": 0, "op": total, "st": 0,
               "ks": {"o": static(100), "r": static(0), "p": static([16, 16]), "a": static([16, 16]),
                      "s": static([100, 100]) if mode == "in" else prop([0, 60, total], [[100, 100], [102.5, 102.5], [100, 100]])}}
    layers.append(breathe)
    ind = 2
    flat = 0
    for d, sw, filled, roles in FACES[kind]:
        path = parse_path(d)
        subs = path.continuous_subpaths()
        assert len(subs) == len(roles), (kind, d, len(subs), roles)
        for sub, role in zip(subs, roles):
            center = bbox_center(sub)
            if mode == "in":
                pos, scale, rot, opa = in_motion(role, center, flat)
            else:
                pos, scale, rot, opa = idle_motion(role, center)
            items = [{"ty": "sh", "ks": static(subpath_shape(sub)), "nm": "Path"}]
            if mode == "in" and not filled:
                items.append(trim_in(flat))
            if filled:
                items.append({"ty": "fl", "c": {"a": 0, "k": INK, "sid": "ink"}, "o": static(100), "r": 1, "nm": "Fill"})
            else:
                items.append({"ty": "st", "c": {"a": 0, "k": INK, "sid": "ink"}, "o": static(100), "w": static(sw),
                              "lc": 2, "lj": 2, "nm": "Stroke"})
            items.append({"ty": "tr", "p": static([0, 0]), "a": static([0, 0]), "s": static([100, 100]),
                          "r": static(0), "o": static(100), "sk": static(0), "sa": static(0)})
            layer = {
                "ty": 4, "ddd": 0, "sr": 1, "ao": 0, "bm": 0, "ind": ind, "parent": 1, "nm": f"{role}", "ip": (flat * 2 if mode == "in" else 0), "op": total, "st": 0,
                "ks": {
                    "o": opa or static(100),
                    "r": rot or static(0),
                    "p": pos or static(center),
                    "a": static(center),
                    "s": scale or static([100, 100]),
                },
                "shapes": [{"ty": "gr", "it": items, "nm": role}],
            }
            layers.append(layer)
            ind += 1
            flat += 1
    return {
        "v": "5.12.1", "fr": FPS, "ip": 0, "op": total, "w": 32, "h": 32, "nm": f"{kind}_{mode}", "ddd": 0,
        "assets": [], "layers": layers,
        "slots": {"ink": {"p": {"a": 0, "k": INK}}},
    }

def build_file():
    out = ROOT / "assets" / "faces.lottie"
    out.parent.mkdir(exist_ok=True)
    anims, manifest = {}, []
    for kind in FACES:
        for mode in ("in", "idle"):
            aid = f"{kind}_{mode}"
            anims[aid] = build_anim(kind, mode)
            # dotLottie v2 is strict (additionalProperties: false): an animation entry may only carry
            # id, initialTheme, background and themes. Loop and autoplay are set by the player.
            manifest.append({"id": aid})
    mf = {"version": "2", "generator": "repara faces_lab", "initial": {"animation": "good_in"}, "animations": manifest}
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("manifest.json", json.dumps(mf))
        for aid, data in anims.items():
            z.writestr(f"a/{aid}.json", json.dumps(data, separators=(",", ":")))
    print("wrote", out, out.stat().st_size, "bytes,", len(anims), "animations")
    return anims

def preview(anims):
    from rlottie_python import LottieAnimation
    from PIL import Image, ImageDraw
    size = 128
    kinds = list(FACES)
    frames = [0, 30, 75, 78, 100]
    sheet = Image.new("RGB", (size * len(frames) + 90, size * len(kinds)), "white")
    d = ImageDraw.Draw(sheet)
    for r, kind in enumerate(kinds):
        a = LottieAnimation.from_data(json.dumps(anims[f"{kind}_idle"]))
        for c, f in enumerate(frames):
            im = a.render_pillow_frame(frame_num=f, width=size, height=size).convert("RGBA")
            bg = Image.new("RGBA", im.size, "white"); bg.alpha_composite(im)
            sheet.paste(bg.convert("RGB"), (90 + c * size, r * size))
        d.text((6, r * size + 56), kind, fill="black")
    p = ROOT / "tool" / "preview_idle.png"; sheet.save(p); print("preview", p)
    sheet2 = Image.new("RGB", (size * 6, size * len(kinds)), "white")
    for r, kind in enumerate(kinds):
        a = LottieAnimation.from_data(json.dumps(anims[f"{kind}_in"]))
        for c, f in enumerate([0, 6, 12, 18, 24, 29]):
            im = a.render_pillow_frame(frame_num=f, width=size, height=size).convert("RGBA")
            bg = Image.new("RGBA", im.size, "white"); bg.alpha_composite(im)
            sheet2.paste(bg.convert("RGB"), (c * size, r * size))
    p = ROOT / "tool" / "preview_in.png"; sheet2.save(p); print("preview", p)

if __name__ == "__main__":
    anims = build_file()
    if "--preview" in sys.argv:
        preview(anims)
