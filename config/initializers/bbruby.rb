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
                                '<div class="more"><b>\2</b>\3</div>',
                                'Reply text',
                                '[more=cut]Original Text[/more]',
                                :more
                            ],
                        })
end