module BBRuby
  # noinspection RubyClassVariableUsageInspection
  @@tags = @@tags.merge({
                            'Reply' => [
                                /\[reply=(.*?)\](.*?)\[\/reply\]/mi,
                                '<div class="quoted"><b>\1</b>\2</div>',
                                'Reply text',
                                '[reply=date|person]Original Text[/reply]',
                                :reply
                            ],
                            'OOC' => [
                                /\[ooc\](.*?)\[\/ooc\]/mi,
                                '<div class="ooc">\1</div>',
                                'OOC text',
                                '[ooc]OOC Text[/ooc]',
                                :ooc
                            ],
                            'More' => [
                                /\[more=(.*?)\](.*?)\[\/more\]/mi,
                                # '<span class="read_more">\1</span><div class="more">\2</div>',
                                '<more cut-text="\1">\2</more>',
                                'More block',
                                '[more=cut]Original Text[/more]',
                                :more
                            ],
                            'More (With no cut text)' => [
                                /\[more\](.*?)\[\/more\]/mi,
                                # '<span class="read_more">читать дальше</span><div class="more">\1</div>',
                                '<more>\1</more>',
                                'More block',
                                '[more]Original Text[/more]',
                                :more
                            ]
                        })
end