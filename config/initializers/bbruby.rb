module BBRuby
  # noinspection RubyClassVariableUsageInspection
  @@tags = @@tags.merge({
                            'Reply' => [
                                /\[reply(:.*)?=(.*?)\](.*?)\[\/reply\1?\]/mi,
                                '<div class="quoted"><b>\2</b>\3</div>',
                                'Reply text',
                                '[reply=date|person]Original Text[/reply]',
                                :reply
                            ],
                        })
end