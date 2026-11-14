import { assertEquals } from "jsr:@std/assert@1";
import { looksLikeCrisis } from "./crisis.ts";

const flagged = (phrases: string[]) => phrases.map((phrase) => [phrase, looksLikeCrisis(phrase)]);

Deno.test("self-harm and suicide wording in Portuguese is flagged", () => {
  const phrases = [
    "eu penso em suicídio",
    "pensei em suicidio ontem",
    "eu quero me matar",
    "quero morrer",
    "não quero mais viver",
    "nao quero viver assim",
    "às vezes eu queria desaparecer",
    "eu vou me machucar",
    "eu me cortei de novo",
    "tomei os remédios todos",
    "não aguento mais",
  ];
  assertEquals(flagged(phrases).filter(([, hit]) => !hit), []);
});

Deno.test("self-harm and suicide wording in English is flagged", () => {
  const phrases = [
    "I want to die",
    "I'm going to kill myself",
    "I want to end my life",
    "I might hurt myself",
    "thoughts of self-harm",
    "I don't want to live anymore",
    "everyone would be better off dead",
  ];
  assertEquals(flagged(phrases).filter(([, hit]) => !hit), []);
});

Deno.test("fear of or violence from a partner is flagged in both languages", () => {
  const phrases = [
    "ele me bate quando bebe",
    "ela me ameaça",
    "tenho medo dele",
    "he hits me when he is angry",
    "I am afraid of my partner",
    "she threatens me",
  ];
  assertEquals(flagged(phrases).filter(([, hit]) => !hit), []);
});

Deno.test("detection ignores letter case", () => {
  assertEquals(looksLikeCrisis("QUERO MORRER"), true);
  assertEquals(looksLikeCrisis("I Want To Die"), true);
});

Deno.test("an everyday figure of speech or ordinary text is not flagged", () => {
  const phrases = [
    "vou me matar de rir com essa piada",
    "hoje o dia foi ótimo",
    "ela fez o café antes de eu acordar",
    "we had a lovely dinner and talked about the trip",
    "",
  ];
  assertEquals(flagged(phrases).filter(([, hit]) => hit), []);
});
