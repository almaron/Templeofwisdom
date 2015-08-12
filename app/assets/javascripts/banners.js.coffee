$ ->
  Msrc = 'http://palantir.in/count.php?id=12390&cid=counter2007_20.png&cntc=none&rand=' +
    Math.random() + "&p=0&wh=" + screen.width + 'x' + screen.height +
    "&referer="+escape(document.referrer)+'&pg='+escape(window.location.href)

  img = $('<img>',
    src: Msrc,
    alt: 'Palantir',
    title: 'Каталог фэнтези сайтов Палантир',
    border: 0,
    width: '88px',
    height: '31px'
  )

  noscript = $('<noscript>').append $('<img>',
    src: "http://palantir.in/count.php?id=12390&cid=counter2007_20.png",
    alt: "Palantir",
    title: "Каталог фэнтези сайтов Палантир",
    border: 0,
    width: "88px",
    height: "31px"
  )

  link = $('<a>',
    href: 'http://palantir.in/?from=12390',
    target: '_blank'
  ).append(img).append(noscript)

  $('.palantir-banner').append link
