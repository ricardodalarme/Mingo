SET local check_function_bodies = off;

CREATE OR REPLACE FUNCTION private.drop_bothered_slip_from_drafts()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
begin
  delete from public.card_items i using public.cards c
  where i.slip_id = new.id and c.id = i.card_id and c.status <> 'sent';
  return new;
end $function$;

CREATE TRIGGER slips_bothered_leave_drafts
  AFTER UPDATE OF polarity ON public.slips
  FOR EACH ROW
  WHEN (((new.polarity = 'bothered'::public.slip_polarity) AND (old.polarity <> 'bothered'::public.slip_polarity)))
  EXECUTE FUNCTION private.drop_bothered_slip_from_drafts();

REVOKE ALL ON FUNCTION "private"."drop_bothered_slip_from_drafts"() FROM PUBLIC;

REVOKE ALL ON FUNCTION "private"."drop_bothered_slip_from_drafts"() FROM "postgres";

GRANT EXECUTE ON FUNCTION "private"."drop_bothered_slip_from_drafts"() TO "postgres";
