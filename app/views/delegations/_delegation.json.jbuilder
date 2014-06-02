json.id delegation.id
json.user_id delegation.user_id
json.username delegation.user.name
json.end_date delegation.ending ? I18n.l(delegation.ending) : I18n.t("char_delegation.ending_nil")