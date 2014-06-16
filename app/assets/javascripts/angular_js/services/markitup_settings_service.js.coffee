@app.factory('markitupSettings', [()->
  markset = [
    {name:'Bold', key:'B', openWith:'[b]', closeWith:'[/b]', faClass:'bold'},
    {name:'Italic', key:'I', openWith:'[i]', closeWith:'[/i]', faClass:'italic'},
    {name:'Underline', key:'U', openWith:'[u]', closeWith:'[/u]', faClass:'underline'},
    {separator:'---------------' },
    {name:'Picture', key:'P', openWith:'[img]', closeWith:'[/img]', placeHolder:'Адрес картинки', faClass:'picture-o'},
    {name:'Link', key:'L', openWith:'[url=]', closeWith:'[/url]', placeHolder:'Ссылка', faClass:"link"},
    {separator:'---------------' },
    {name:'Bulleted list', openWith:'[list]\n', closeWith:'\n[/list]', faClass:"list-ul"},
    {name:'Numeric list', openWith:'[list=]\n', closeWith:'\n[/list]', faClass:"list-ol"},
    {name:'List item', openWith:'[*] ', span:'[*]', faClass:"list"},
    {separator:'---------------' },
    {name:'Quotes', openWith:'[quote]', closeWith:'[/quote]', faClass:"quote-left"},
    {name:'OOC', openWith:'[ooc]', closeWith:'[/ooc]', faClass:"user", span: 'OOC'},
    {name:'MORE', openWith:'[more=]', closeWith:'[/more]', faClass:"cut",span:'MORE'}
  ]
  factory = {}
  factory.create = (callback) ->
    {
      afterInsert:        callback,
      previewParserPath:	'',
      markupSet:          markset
    }
  return factory
])