// The pronouns the person stated for themselves and for their partner. Never guessed.
export type PronounOptions = {
  pronouns?: string | null;
  partnerPronouns?: string | null;
  partnerName?: string | null;
};

const WORDS: Record<string, { pt: string; en: string }> = {
  she: { pt: 'ela/dela', en: 'she/her' },
  he: { pt: 'ele/dele', en: 'he/him' },
  name_only: { pt: 'sem pronomes: use só o nome', en: 'no pronouns: use the name only' },
};

export function pronounRule(pt: boolean, options: PronounOptions): string {
  const word = (key?: string | null) => (key && WORDS[key] ? WORDS[key][pt ? 'pt' : 'en'] : null);
  const own = word(options.pronouns);
  const partner = word(options.partnerPronouns);
  const name = options.partnerName ? (pt ? ` O nome do parceiro é ${options.partnerName}.` : ` The partner's name is ${options.partnerName}.`) : '';
  if (pt) {
    return ` Pronomes: a pessoa usa ${own ?? 'não informado'}; o parceiro usa ${partner ?? 'não informado'}.${name} Use exatamente esses pronomes; quando não estiverem informados, use o nome ou frases neutras e nunca adivinhe.`;
  }
  return ` Pronouns: the person uses ${own ?? 'not stated'}; their partner uses ${partner ?? 'not stated'}.${name} Use exactly these pronouns; when they are not stated, use the name or neutral phrasing and never guess.`;
}
