#!/usr/bin/env python3
"""Face motion v2: one motion spec -> Lottie JSON (Flutter) + SVG/CSS (design system canvas).

Per face, three animations (30 fps):
  in    draw-on, plays once (36 frames)
  idle  quiet loop (150 frames = 5 s); frame 0 == the static BaseFace drawing
  pop   one-shot reaction on select / receive (24 frames); first and last frame == static drawing

Tracks are offsets from rest: p=(dx,dy) in 32-grid units, s=(sx,sy) in %, r=degrees, o=opacity %.
The ink color is the Lottie slot "ink" (baked value INK, recolored in the app by replacing it).

Run:  python3 tool/gen_faces2.py [--preview]
Out:  assets/faces/<kind>_<mode>.json, build/faces_anim.css, build/faces_anim_cells.json
"""
import json, sys, pathlib, hashlib
from svgpathtools import parse_path
sys.path.insert(0, str(pathlib.Path(__file__).parent))
from gen_faces import FACES, subpath_shape, bbox_center, static, INK  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[2]
FPS = 30
T_IN, T_IDLE, T_POP = 36, 150, 24

# ------------------------------------------------------------------ motion spec
def blink(t, depth=8, dur=7):
    return [(0, [100, 100]), (t, [100, 100]), (t + dur // 2, [100, depth]), (t + dur, [100, 100]), (T_IDLE, [100, 100])]

def wave(pairs, rest, end=T_IDLE):
    """Keyframes from [(frame, value)], closed with the rest value at 0 and end."""
    out = [(0, rest)] + [(t, v) for t, v in pairs] + [(end, rest)]
    return out

R2 = [100, 100]
IDLE = {
  "good": {
    "_face": {"s": [(0, R2), (75, [102.5, 102.5]), (150, R2)]},
    "eyeL": {"s": blink(96), "p": wave([(56, [0, 0]), (72, [0, -0.45]), (96, [0, 0])], [0, 0])},
    "eyeR": {"s": blink(97), "p": wave([(56, [0, 0]), (72, [0, -0.45]), (96, [0, 0])], [0, 0])},
    "mouth": {"s": wave([(40, R2), (66, [106, 114]), (96, R2)], R2)},
  },
  "affectionate": {
    "_face": {"s": [(0, R2), (75, [102.5, 102.5]), (150, R2)]},
    "heartL": {"s": [(0, R2), (18, R2), (23, [118, 118]), (28, R2), (33, [111, 111]), (40, R2),
                     (90, R2), (95, [118, 118]), (100, R2), (105, [111, 111]), (112, R2), (150, R2)]},
    "heartR": {"s": [(0, R2), (21, R2), (26, [118, 118]), (31, R2), (36, [111, 111]), (43, R2),
                     (93, R2), (98, [118, 118]), (103, R2), (108, [111, 111]), (115, R2), (150, R2)]},
    "mouth": {"s": wave([(40, R2), (66, [104, 112]), (96, R2)], R2)},
  },
  "tired": {
    "_face": {"s": [(0, R2), (75, [101.5, 101.5]), (150, R2)], "r": [(0, 0), (45, 0), (85, -2.6), (130, 0), (150, 0)]},
    "eyeL": {"s": wave([(44, R2), (70, [100, 55]), (96, [100, 55]), (118, R2)], R2),
             "p": wave([(44, [0, 0]), (70, [0, 0.55]), (96, [0, 0.55]), (118, [0, 0])], [0, 0])},
    "eyeR": {"s": wave([(44, R2), (70, [100, 55]), (96, [100, 55]), (118, R2)], R2),
             "p": wave([(44, [0, 0]), (70, [0, 0.55]), (96, [0, 0.55]), (118, [0, 0])], [0, 0])},
    "mouth": {"s": wave([(44, R2), (84, [118, 100]), (118, R2)], R2)},
    "zzz": {"p": [(0, [0, 0]), (50, [0, 0]), (108, [0.9, -3.2]), (109, [-0.4, 1.8]), (150, [0, 0])],
            "o": [(0, [100]), (50, [100]), (100, [0]), (112, [0]), (140, [100]), (150, [100])]},
  },
  "tense": {
    "_face": {"s": [(0, R2), (75, [101.5, 101.5]), (150, R2)],
              "p": [(0, [0, 0]), (58, [0, 0]), (60, [0.35, 0]), (62, [-0.35, 0]), (64, [0.3, 0]), (66, [0, 0]), (150, [0, 0])]},
    "browL": {"r": [(0, 0), (56, 0), (60, 4), (63, -2), (66, 3), (70, 0), (150, 0)],
              "p": [(0, [0, 0]), (56, [0, 0]), (60, [0, 0.5]), (70, [0, 0]), (150, [0, 0])]},
    "browR": {"r": [(0, 0), (56, 0), (60, -4), (63, 2), (66, -3), (70, 0), (150, 0)],
              "p": [(0, [0, 0]), (56, [0, 0]), (60, [0, 0.5]), (70, [0, 0]), (150, [0, 0])]},
    "eyeL": {"s": blink(120, 12, 6), "p": wave([(86, [0, 0]), (96, [-0.8, 0]), (108, [-0.8, 0]), (118, [0, 0])], [0, 0])},
    "eyeR": {"s": blink(120, 12, 6), "p": wave([(86, [0, 0]), (96, [-0.8, 0]), (108, [-0.8, 0]), (118, [0, 0])], [0, 0])},
    "mouth": {"p": [(0, [0, 0]), (56, [0, 0]), (59, [0.5, 0]), (62, [-0.5, 0]), (65, [0.4, 0]), (68, [0, 0]), (150, [0, 0])]},
  },
  "sad": {
    "_face": {"s": [(0, R2), (75, [101.8, 101.8]), (150, R2)]},
    "eyeL": {"s": blink(128, 10, 8)},
    "eyeR": {"s": blink(129, 10, 8)},
    "mouth": {"s": [(0, R2), (50, R2), (54, [98, 100]), (58, [102, 100]), (62, [99, 100]), (66, R2), (150, R2)]},
    "tear": {"p": [(0, [0, 0]), (30, [0, 0]), (62, [0, 7.5]), (63, [0, 0]), (150, [0, 0])],
             "o": [(0, [100]), (30, [100]), (60, [0]), (100, [0]), (118, [100]), (150, [100])],
             "s": [(0, R2), (30, R2), (60, [92, 92]), (62, [0, 0]), (100, [0, 0]), (118, R2), (150, R2)]},
  },
  "thinking": {
    "_face": {"s": [(0, R2), (75, [102, 102]), (150, R2)], "r": [(0, 0), (30, 0), (60, -2.2), (110, -2.2), (140, 0), (150, 0)]},
    "eyeLook": {"p": [(0, [0, 0]), (24, [0, 0]), (36, [-0.8, -0.3]), (74, [-0.8, -0.3]), (88, [0.8, -0.3]), (116, [0.8, -0.3]), (130, [0, 0]), (150, [0, 0])],
                "s": blink(138, 10, 7)},
    "nose": {"p": [(0, [0, 0]), (24, [0, 0]), (36, [-0.4, 0]), (74, [-0.4, 0]), (88, [0.4, 0]), (116, [0.4, 0]), (130, [0, 0]), (150, [0, 0])]},
    "mouth": {"p": [(0, [0, 0]), (36, [0, 0]), (50, [-0.35, 0]), (110, [-0.35, 0]), (128, [0, 0]), (150, [0, 0])]},
    "sparkA": {"o": [(0, [100]), (25, [35]), (50, [100]), (75, [35]), (100, [100]), (125, [35]), (150, [100])],
               "s": [(0, R2), (25, [90, 90]), (50, R2), (75, [90, 90]), (100, R2), (125, [90, 90]), (150, R2)]},
    "sparkB": {"o": [(0, [100]), (12, [100]), (37, [35]), (62, [100]), (87, [35]), (112, [100]), (137, [35]), (150, [60])],
               "s": [(0, R2), (37, [90, 90]), (62, R2), (87, [90, 90]), (112, R2), (137, [90, 90]), (150, [96, 96])]},
  },
  "smile": {
    "_face": {"s": [(0, R2), (75, [102.5, 102.5]), (150, R2)]},
    "eyeSmile": {"p": wave([(50, [0, 0]), (70, [0, -0.5]), (100, [0, 0])], [0, 0]),
                 "s": wave([(50, R2), (70, [104, 104]), (100, R2)], R2)},
    "mouth": {"s": wave([(46, R2), (70, [104, 114]), (100, R2)], R2)},
    "sparkA": {"o": [(0, [100]), (30, [30]), (60, [100]), (90, [30]), (120, [100]), (150, [100])],
               "s": [(0, R2), (30, [88, 88]), (60, [108, 108]), (90, [88, 88]), (120, R2), (150, R2)]},
    "sparkB": {"o": [(0, [100]), (15, [100]), (45, [30]), (75, [100]), (105, [30]), (135, [100]), (150, [100])],
               "s": [(0, R2), (45, [88, 88]), (75, [108, 108]), (105, [88, 88]), (135, R2), (150, R2)]},
  },
}

POP_FACE = {"s": [(0, R2), (5, [90, 90]), (11, [113, 113]), (17, [97, 97]), (24, R2)]}
def pop_blink(depth):  # eyes squeeze on the pop
    return [(0, R2), (6, [100, depth]), (14, R2), (24, R2)]
POP = {
  "good": {"_face": POP_FACE,
           "mouth": {"s": [(0, R2), (10, [112, 128]), (18, [102, 104]), (24, R2)]},
           "eyeL": {"p": [(0, [0, 0]), (10, [0, -0.7]), (24, [0, 0])]},
           "eyeR": {"p": [(0, [0, 0]), (10, [0, -0.7]), (24, [0, 0])]}},
  "affectionate": {"_face": POP_FACE,
           "heartL": {"s": [(0, R2), (8, [145, 145]), (16, [104, 104]), (24, R2)], "p": [(0, [0, 0]), (8, [0, -1.2]), (24, [0, 0])]},
           "heartR": {"s": [(0, R2), (10, [145, 145]), (18, [104, 104]), (24, R2)], "p": [(0, [0, 0]), (10, [0, -1.2]), (24, [0, 0])]},
           "mouth": {"s": [(0, R2), (10, [110, 124]), (24, R2)]}},
  "tired": {"_face": {"s": [(0, R2), (6, [96, 96]), (14, [102, 102]), (24, R2)], "r": [(0, 0), (7, -4), (16, 1.5), (24, 0)]},
           "eyeL": {"s": [(0, R2), (6, [100, 25]), (16, [100, 25]), (24, R2)]},
           "eyeR": {"s": [(0, R2), (6, [100, 25]), (16, [100, 25]), (24, R2)]},
           "zzz": {"p": [(0, [0, 0]), (14, [1, -3]), (15, [0, 1.5]), (24, [0, 0])],
                   "o": [(0, [100]), (10, [100]), (14, [0]), (17, [0]), (24, [100])]}},
  "tense": {"_face": {"p": [(0, [0, 0]), (3, [0.5, 0]), (6, [-0.5, 0]), (9, [0.4, 0]), (12, [-0.3, 0]), (15, [0, 0]), (24, [0, 0])],
                      "s": [(0, R2), (6, [96, 96]), (24, R2)]},
           "browL": {"r": [(0, 0), (5, 6), (12, -2), (24, 0)], "p": [(0, [0, 0]), (5, [0, 0.8]), (24, [0, 0])]},
           "browR": {"r": [(0, 0), (5, -6), (12, 2), (24, 0)], "p": [(0, [0, 0]), (5, [0, 0.8]), (24, [0, 0])]},
           "eyeL": {"s": pop_blink(40)}, "eyeR": {"s": pop_blink(40)},
           "mouth": {"p": [(0, [0, 0]), (3, [0.6, 0]), (6, [-0.6, 0]), (9, [0.5, 0]), (12, [0, 0]), (24, [0, 0])]}},
  "sad": {"_face": {"s": [(0, R2), (8, [97, 97]), (18, [101, 101]), (24, R2)]},
           "eyeL": {"s": pop_blink(40)}, "eyeR": {"s": pop_blink(40)},
           "mouth": {"s": [(0, R2), (6, [98, 100]), (10, [103, 100]), (14, [98, 100]), (18, [101, 100]), (24, R2)]},
           "tear": {"p": [(0, [0, 0]), (8, [0, 0]), (17, [0, 7.5]), (18, [0, 0]), (24, [0, 0])],
                    "o": [(0, [100]), (8, [100]), (16, [0]), (19, [0]), (24, [100])],
                    "s": [(0, R2), (8, R2), (16, [92, 92]), (17, [0, 0]), (19, [0, 0]), (24, R2)]}},
  "thinking": {"_face": {"s": [(0, R2), (6, [94, 94]), (13, [108, 108]), (24, R2)], "r": [(0, 0), (8, -4), (24, 0)]},
           "eyeLook": {"p": [(0, [0, 0]), (8, [-1, -0.4]), (17, [1, -0.4]), (24, [0, 0])]},
           "sparkA": {"o": [(0, [100]), (6, [20]), (12, [100]), (18, [30]), (24, [100])], "s": [(0, R2), (6, [140, 140]), (12, R2), (24, R2)]},
           "sparkB": {"o": [(0, [100]), (9, [20]), (15, [100]), (21, [30]), (24, [100])], "s": [(0, R2), (9, [140, 140]), (15, R2), (24, R2)]}},
  "smile": {"_face": POP_FACE,
           "eyeSmile": {"p": [(0, [0, 0]), (10, [0, -0.7]), (24, [0, 0])], "s": [(0, R2), (10, [108, 108]), (24, R2)]},
           "mouth": {"s": [(0, R2), (10, [108, 128]), (18, [102, 104]), (24, R2)]},
           "sparkA": {"o": [(0, [100]), (6, [40]), (12, [100]), (24, [100])], "s": [(0, R2), (8, [150, 150]), (16, R2), (24, R2)]},
           "sparkB": {"o": [(0, [100]), (8, [40]), (14, [100]), (24, [100])], "s": [(0, R2), (10, [150, 150]), (18, R2), (24, R2)]}},
}

# ------------------------------------------------------------------ helpers
EASE_IO = ([0.42, 0.0], [0.58, 1.0])  # css cubic-bezier(.42,0,.58,1)

def lottie_prop(keys, conv):
    """keys: [(frame, value)] -> Lottie animated property."""
    dedup = []
    for t, v in keys:
        if dedup and dedup[-1][0] == t:
            dedup[-1] = (t, v)
        else:
            dedup.append((t, v))
    keys = dedup
    vals = [conv(v) for _, v in keys]
    if all(v == vals[0] for v in vals):
        return {"a": 0, "k": vals[0]}
    ks = []
    for idx, ((t, _), v) in enumerate(zip(keys, vals)):
        k = {"t": t, "s": v if isinstance(v, list) else [v]}
        if idx < len(keys) - 1:
            n = len(k["s"])
            k["i"] = {"x": [0.58] * n, "y": [1] * n}
            k["o"] = {"x": [0.42] * n, "y": [0] * n}
        ks.append(k)
    return {"a": 1, "k": ks}

def scalar(v): return v[0] if isinstance(v, list) else v

def draw_trim(i):
    d = i * 3
    e = {"a": 1, "k": [
        {"t": d, "s": [0], "i": {"x": [0.42], "y": [1]}, "o": {"x": [0.58], "y": [0]}},
        {"t": d + 18, "s": [100]}, ]}
    return {"ty": "tm", "s": static(0), "e": e, "o": static(0), "m": 1, "nm": "Draw on"}

def tracks_for(kind, mode, role):
    src = {"idle": IDLE, "pop": POP}.get(mode, {})
    return src.get(kind, {}).get(role, {})

# ------------------------------------------------------------------ elements
def elements(kind):
    """[(role, sub_d, center, stroke_w, filled)] in drawing order."""
    out = []
    for d, sw, filled, roles in FACES[kind]:
        subs = parse_path(d).continuous_subpaths()
        assert len(subs) == len(roles), (kind, d)
        for sub, role in zip(subs, roles):
            out.append((role, sub, bbox_center(sub), sw, filled))
    return out

# ------------------------------------------------------------------ Lottie
def build_lottie(kind, mode):
    total = {"in": T_IN, "idle": T_IDLE, "pop": T_POP}[mode]
    face = tracks_for(kind, mode, "_face")
    fk = {
        "o": static(100),
        "r": lottie_prop(face["r"], scalar) if "r" in face else static(0),
        "p": lottie_prop([(t, [16 + v[0], 16 + v[1]]) for t, v in face["p"]], lambda v: v) if "p" in face else static([16, 16]),
        "a": static([16, 16]),
        "s": lottie_prop(face["s"], lambda v: v) if "s" in face else static([100, 100]),
    }
    if mode == "in":
        fk["s"] = lottie_prop([(0, [94, 94]), (T_IN, [100, 100])], lambda v: v)
    layers = [{"ty": 3, "ddd": 0, "sr": 1, "ao": 0, "bm": 0, "ind": 1, "nm": "Face", "ip": 0, "op": total, "st": 0, "ks": fk}]
    ind = 2
    for idx, (role, sub, c, sw, filled) in enumerate(elements(kind)):
        tr = tracks_for(kind, mode, role)
        ks = {"o": static(100), "r": static(0), "p": static(c), "a": static(c), "s": static([100, 100])}
        if "s" in tr: ks["s"] = lottie_prop(tr["s"], lambda v: v)
        if "r" in tr: ks["r"] = lottie_prop(tr["r"], scalar)
        if "o" in tr: ks["o"] = lottie_prop(tr["o"], scalar)
        if "p" in tr: ks["p"] = lottie_prop([(t, [c[0] + v[0], c[1] + v[1]]) for t, v in tr["p"]], lambda v: v)
        items = [{"ty": "sh", "ks": static(subpath_shape(sub)), "nm": "Path"}]
        ip = 0
        if mode == "in":
            d = idx * 3
            ip = 0
            if filled or role in ("tear",):
                ks["s"] = lottie_prop([(0, [0, 0]), (d, [0, 0]), (d + 8, [120, 120]), (d + 14, [96, 96]), (d + 20, [100, 100]), (T_IN, [100, 100])], lambda v: v)
                ks["o"] = lottie_prop([(0, [0]), (d, [0]), (d + 2, [100]), (T_IN, [100])], scalar)
            else:
                items.append(draw_trim(idx))
                ks["o"] = lottie_prop([(0, [0]), (d, [0]), (d + 2, [100]), (T_IN, [100])], scalar)
        if filled:
            items.append({"ty": "fl", "c": {"a": 0, "k": INK, "sid": "ink"}, "o": static(100), "r": 1, "nm": "Fill"})
        else:
            items.append({"ty": "st", "c": {"a": 0, "k": INK, "sid": "ink"}, "o": static(100), "w": static(sw),
                          "lc": 2, "lj": 2, "nm": "Stroke"})
        items.append({"ty": "tr", "p": static([0, 0]), "a": static([0, 0]), "s": static([100, 100]),
                      "r": static(0), "o": static(100), "sk": static(0), "sa": static(0)})
        layers.append({"ty": 4, "ddd": 0, "sr": 1, "ao": 0, "bm": 0, "ind": ind, "parent": 1, "nm": role,
                       "ip": ip, "op": total, "st": 0, "ks": ks, "shapes": [{"ty": "gr", "it": items, "nm": role}]})
        ind += 1
    return {"v": "5.12.1", "fr": FPS, "ip": 0, "op": total, "w": 32, "h": 32, "nm": f"{kind}_{mode}", "ddd": 0,
            "assets": [], "layers": layers, "slots": {"ink": {"p": {"a": 0, "k": INK}}}}

# ------------------------------------------------------------------ SVG + CSS for the design system
def css_value(tr, t_idx, rest_scale=R2):
    return None

def kf_css(name, total, keys_by_prop, mode_in=None):
    """Build @keyframes: every stop writes transform + opacity so interpolation is consistent."""
    frames = sorted({t for ks in keys_by_prop.values() for t, _ in ks})
    def at(prop, t, default):
        ks = keys_by_prop.get(prop)
        if not ks: return default
        for tt, v in ks:
            if tt == t: return v
        # interpolate (linear is enough to place intermediate stops)
        prev = max((x for x in ks if x[0] < t), key=lambda x: x[0], default=ks[0])
        nxt = min((x for x in ks if x[0] > t), key=lambda x: x[0], default=ks[-1])
        if nxt[0] == prev[0]: return prev[1]
        f = (t - prev[0]) / (nxt[0] - prev[0])
        a, b = prev[1], nxt[1]
        return [x + (y - x) * f for x, y in zip(a, b)] if isinstance(a, list) else a + (b - a) * f
    lines = []
    for t in frames:
        p = at("p", t, [0, 0]); s = at("s", t, [100, 100]); r = at("r", t, 0); o = at("o", t, [100])
        r = r[0] if isinstance(r, list) else r
        o = o[0] if isinstance(o, list) else o
        lines.append(f"{round(t / total * 100, 3)}%{{transform:translate({p[0]:.3g}px,{p[1]:.3g}px) rotate({r:.3g}deg) scale({s[0] / 100:.4g},{s[1] / 100:.4g});opacity:{o / 100:.3g}}}")
    return f"@keyframes {name}{{{''.join(lines)}}}"

def build_css_and_svg():
    """Returns (css, svgs) where svgs[kind][mode] is inline <svg> markup (class-based, theme ink = currentColor)."""
    kf_cache, css_parts, svgs = {}, [], {}
    def kf(ptotal, keys):
        sig = hashlib.md5((str(ptotal) + json.dumps(keys, sort_keys=True)).encode()).hexdigest()[:8]
        name = f"fk{sig}"
        if name not in kf_cache:
            kf_cache[name] = kf_css(name, ptotal, keys)
        return name
    for kind in FACES:
        svgs[kind] = {}
        still = "".join(f'<path d="{sub.d()}"' + (' fill="currentColor" stroke="none"' if filled else f' stroke-width="{sw}"') + '/>'
                        for role, sub, c, sw, filled in elements(kind))
        svgs[kind]["still"] = ('<svg viewBox="0 0 32 32" fill="none" stroke="currentColor" stroke-linecap="round" '
                               f'stroke-linejoin="round">{still}</svg>')
        for mode in ("in", "idle", "pop"):
            total = {"in": T_IN, "idle": T_IDLE, "pop": T_POP}[mode]
            # Preview loops: one-shot animations are padded with a hold so the canvas shows them repeating.
            ptotal = {"in": 96, "idle": T_IDLE, "pop": 90}[mode]
            dur = ptotal / FPS
            # face wrapper
            face = dict(tracks_for(kind, mode, "_face"))
            if mode == "in":
                face = {"s": [(0, [94, 94]), (T_IN, [100, 100])]}
            if face:
                fname = kf(ptotal, face)
                wrap = f'<g style="transform-origin:16px 16px;animation:{fname} var(--d,{dur}s) var(--ez,cubic-bezier(.42,0,.58,1)) var(--it,infinite)">'
            else:
                wrap = '<g>'
            body = []
            for idx, (role, sub, c, sw, filled) in enumerate(elements(kind)):
                tr = dict(tracks_for(kind, mode, role))
                style = "transform-box:fill-box;transform-origin:center;"
                attrs = ""
                d = sub.d()
                if mode == "in":
                    dl = idx * 3
                    if filled or role == "tear":
                        keys = {"s": [(0, [0, 0]), (dl, [0, 0]), (dl + 8, [120, 120]), (dl + 14, [96, 96]), (dl + 20, [100, 100]), (T_IN, [100, 100])],
                                "o": [(0, [0]), (dl, [0]), (dl + 2, [100]), (T_IN, [100])]}
                        style += f"animation:{kf(ptotal, keys)} var(--d,{dur}s) var(--ez,cubic-bezier(.42,0,.58,1)) var(--it,infinite);"
                    else:
                        okeys = {"o": [(0, [0]), (dl, [0]), (dl + 2, [100]), (T_IN, [100])]}
                        dkeys = [(0, 1), (dl, 1), (dl + 18, 0), (T_IN, 0)]
                        dn = f"fd{hashlib.md5(json.dumps(dkeys).encode()).hexdigest()[:6]}"
                        if dn not in kf_cache:
                            kf_cache[dn] = "@keyframes %s{%s}" % (dn, "".join(f"{round(t / ptotal * 100, 3)}%{{stroke-dashoffset:{v}}}" for t, v in dkeys))
                        style += (f"stroke-dasharray:1 1;animation:{dn} var(--d,{dur}s) var(--ez,cubic-bezier(.42,0,.58,1)) var(--it,infinite),"
                                  f"{kf(ptotal, okeys)} var(--d,{dur}s) linear var(--it,infinite);")
                        attrs = ' pathLength="1"'
                elif tr:
                    style += f"animation:{kf(ptotal, tr)} var(--d,{dur}s) var(--ez,cubic-bezier(.42,0,.58,1)) var(--it,infinite);"
                fill = ' fill="currentColor" stroke="none"' if filled else f' stroke-width="{sw}"'
                body.append(f'<path d="{d}"{attrs}{fill} style="{style}"/>')
            svgs[kind][mode] = (
                '<svg viewBox="0 0 32 32" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">'
                f'{wrap}{"".join(body)}</g></svg>')
    css = "".join(kf_cache.values())
    return css, svgs

# ------------------------------------------------------------------ main
def main():
    out = ROOT / "assets" / "faces"
    out.mkdir(parents=True, exist_ok=True)
    for old in out.glob("*.json"): old.unlink()
    total = 0
    anims = {}
    for kind in FACES:
        for mode in ("in", "idle", "pop"):
            data = build_lottie(kind, mode)
            anims[f"{kind}_{mode}"] = data
            s = json.dumps(data, separators=(",", ":"))
            (out / f"{kind}_{mode}.json").write_text(s)
            total += len(s)
    print(f"wrote {len(anims)} animations to {out} ({total / 1024:.1f} KB)")
    css, svgs = build_css_and_svg()
    b = ROOT / "build"; b.mkdir(exist_ok=True)
    (b / "faces_anim.css").write_text(css)
    (b / "faces_anim_svgs.json").write_text(json.dumps(svgs))
    print(f"css {len(css) / 1024:.1f} KB")
    if "--preview" in sys.argv: preview(anims)

def preview(anims):
    from rlottie_python import LottieAnimation
    from PIL import Image, ImageDraw
    size = 110
    kinds = list(FACES)
    for mode, frames in (("idle", [0, 20, 45, 66, 80, 100, 112, 125]), ("pop", [0, 4, 8, 12, 16, 20, 23]), ("in", [0, 6, 12, 18, 24, 30, 35])):
        sheet = Image.new("RGB", (80 + size * len(frames), size * len(kinds)), "white")
        d = ImageDraw.Draw(sheet)
        for r, kind in enumerate(kinds):
            a = LottieAnimation.from_data(json.dumps(anims[f"{kind}_{mode}"]))
            for c, f in enumerate(frames):
                im = a.render_pillow_frame(frame_num=f, width=size, height=size).convert("RGBA")
                bg = Image.new("RGBA", im.size, "white"); bg.alpha_composite(im)
                sheet.paste(bg.convert("RGB"), (80 + c * size, r * size))
            d.text((6, r * size + 50), kind, fill="black")
        p = ROOT / "build" / f"preview_{mode}.png"; sheet.save(p); print("preview", p)

if __name__ == "__main__":
    main()
