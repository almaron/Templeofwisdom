@app.factory('markitupSettings', [()->
  markset = [
    {name:'Жирный', key:'B', openWith:'[b]', closeWith:'[/b]', faClass:'bold'},
    {name:'Курсив', key:'I', openWith:'[i]', closeWith:'[/i]', faClass:'italic'},
    {name:'Подчеркнутый', key:'U', openWith:'[u]', closeWith:'[/u]', faClass:'underline'},
    {separator:'&nbsp;' },
    {name:'Вставка картинки', key:'P', openWith:'[img]', closeWith:'[/img]', placeHolder:'Адрес картинки', faClass:'picture-o'},
    {name:'Вставка ссылки', key:'L', openWith:'[url=]', closeWith:'[/url]', placeHolder:'Ссылка', faClass:"link"},
    {separator:'&nbsp;' },
    {name:'Выровнять слева', openWith:'[left]', closeWith:'[/left]',  faClass:"align-left"},
    {name:'Выровнять по центру', openWith:'[center]', closeWith:'[/center]',  faClass:"align-center"},
    {name:'Выровнять справа', openWith:'[right]', closeWith:'[/right]', faClass:"align-right"},
    {separator:'&nbsp;' },
    {name:'Список', openWith:'[list]\n', closeWith:'\n[/list]', faClass:"list-ul"},
    {name:'Нумерация', openWith:'[list=1]\n', closeWith:'\n[/list]', faClass:"list-ol"},
    {name:'Элемент списка', openWith:'[*] ', span:'[*]', faClass:"list"},
    {separator:'&nbsp;' },
    {name:'Цитата', openWith:'[quote]', closeWith:'[/quote]', faClass:"quote-left"},
    {name:'OOC', openWith:'[ooc]', closeWith:'[/ooc]', faClass:"user", span: 'OOC'},
    {name:'MORE', openWith:'[more]', closeWith:'[/more]', faClass:"cut",span:'MORE'}
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
