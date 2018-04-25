error = (title, text = '', links = '') ->
  text = """<p class="_error-text">#{text}</p>""" if text
  links = """<p class="_error-links">#{links}</p>""" if links
  """<div class="_error"><h1 class="_error-title">#{title}</h1>#{text}#{links}</div>"""

back = '<a href="#" data-behavior="back" class="_error-link">Go back</a>'

app.templates.notFoundPage = ->
  error """ Page not found. """,
        """ It may be missing from the source documentation or this could be a bug. """,
        back

app.templates.pageLoadError = ->
  error """ The page failed to load. """,
        """ It may be missing from the server (try reloading the app) or you could be offline.<br>
            If you keep seeing this, you're likely behind a proxy or firewall that blocks cross-domain requests. """,
        """ #{back} &middot; <a href="/##{location.pathname}" target="_top" class="_error-link">Reload</a>
            &middot; <a href="#" class="_error-link" data-retry>Retry</a> """

app.templates.bootError = ->
  error """ The app failed to load. """,
        """ Check your Internet connection and try <a href="#" data-behavior="reload">reloading</a>.<br>
            If you keep seeing this, you're likely behind a proxy or firewall that blocks cross-domain requests. """

app.templates.offlineError = (reason, exception) ->
  if reason is 'cookie_blocked'
    return error """ Cookies must be enabled to use offline mode. """

  reason = switch reason
    when 'not_supported'
      """ DevDocs requires IndexedDB to cache documentations for offline access.<br>
          Unfortunately your browser either doesn't support IndexedDB or doesn't make it available. """
    when 'buggy'
      """ DevDocs requires IndexedDB to cache documentations for offline access.<br>
          Unfortunately your browser's implementation of IndexedDB contains bugs that prevent DevDocs from using it. """
    when 'private_mode'
      """ Your browser appears to be running in private mode.<br>
          This prevents DevDocs from caching documentations for offline access."""
    when 'exception'
      """ An error occurred when trying to open the IndexedDB database:<br>
          <code class="_label">#{exception.name}: #{exception.message}</code> """
    when 'cant_open'
      """ An error occurred when trying to open the IndexedDB database:<br>
          <code class="_label">#{exception.name}: #{exception.message}</code><br>
          This could be because you're browsing in private mode or have disallowed offline storage on the domain. """
    when 'version'
      """ The IndexedDB database was modified with a newer version of the app.<br>
          <a href="#" data-behavior="reload">Reload the page</a> to use offline mode. """
    when 'empty'
      """ The IndexedDB database appears to be corrupted. Try <a href="#" data-behavior="reset">resetting the app</a>. """

  error 'Offline mode is unavailable.', reason

app.templates.unsupportedBrowser = """
  <div class="_fail">
    <h1 class="_fail-title">Your browser is unsupported, sorry.</h1>
    <p class="_fail-text">DevDocs is an API documentation browser which supports the following browsers:
    <ul class="_fail-list">
      <li>Recent versions of Chrome and Firefox
      <li>Safari 5.1+
      <li>Opera 12.1+
      <li>Internet Explorer 10+
      <li>iOS 6+
      <li>Android 4.1+
      <li>Windows Phone 8+
    </ul>
    <p class="_fail-text">
      If you're unable to upgrade, I apologize.
      I decided to prioritize speed and new features over support for older browsers.
    <p class="_fail-text">
      Note: if you're already using one of the browsers above, check your settings and add-ons.
      The app uses feature detection, not user agent sniffing.
    <p class="_fail-text">
      &mdash; Thibaut <a href="https://twitter.com/DevDocs" class="_fail-link">@DevDocs</a>
  </div>
"""

error = (title, text = '', links = '') ->
  text = """<p class="_error-text">#{text}</p>""" if text
  links = """<p class="_error-links">#{links}</p>""" if links
  """<div class="_error"><h1 class="_error-title">#{title}</h1>#{text}#{links}</div>"""

back = '<a href="#" data-behavior="back" class="_error-link">戻る</a>'

app.templates.notFoundPage = ->
  error """ ページが見つかりません。 """,
        """ ドキュメントソースを誤っているか、バグかもしれません。 """,
        back

app.templates.pageLoadError = ->
  error """ ページの読み込みが失敗しました。 """,
        """ サーバーを誤っています。（アプリを再度読み込んでください）または、オフラインです。<br>
            この表示が続くようであれば、プロキシの制限やファイヤーウォールでクロスドメインリクエストがブロックされています。 """,
        """ #{back} &middot; <a href="/##{location.pathname}" target="_top" class="_error-link">再読み込み</a>
            &middot; <a href="#" class="_error-link" data-retry>Retry</a> """

app.templates.bootError = ->
  error """ アプリの読み込みに失敗しました。 """,
        """ インターネット接続を確認してください。<a href="#" data-behavior="reload">再読み込み</a>してください。<br>
            この表示が続くようであれば、プロキシの制限やファイヤーウォールでクロスドメインリクエストがブロックされています。 """

app.templates.offlineError = (reason, exception) ->
  if reason is 'cookie_blocked'
    return error """ オフラインモードを使用してクッキーを有効にする必要があります。 """

  reason = switch reason
    when 'not_supported'
      """Devdocsはオフラインアクセスのために、IndexedDBにキャッシュすることを要求しています。<br>
          あいにく、お使いのブラウザはIndexedDBかキャッシュの作成いずれかが非対応です。"""
    when 'buggy'
      """Devdocsはオフラインアクセスのために、IndexedDBにキャッシュすることを要求しています。<br>
          あいにく、お使いのブラウザはIndexedDB containsの実行バグを防いでいます。"""
    when 'private_mode'
      """ ブラウザのプライベートモードで表示しています。<br>
          オフラインアクセスによってドキュメントのキャッシュが防止されています。"""
    when 'exception'
      """IndexDBデータベースを開く際にエラーが起きています。:<br>
          <code class="_label">#{exception.name}: #{exception.message}</code> """
    when 'cant_open'
      """IndexDBデータベースを開く際にエラーが起きています。:<br>
          <code class="_label">#{exception.name}: #{exception.message}</code><br>
          お使いのブラウザはプライベートモードかオフラインストレージを許可していないため、許可しましょう。"""
    when 'version'
      """IndexedDBデータベースはアプリの新しいバージョンに修正されています。<br>
          <a href="#" data-behavior="reload">ページ再読み込み</a> して、オフラインモードを使ってください。 """
    when 'empty'
      """IndexedDBデータベースに誤りがあります。 <a href="#" data-behavior="reset">アプリをリセット</a>してみてください。 """

  error 'Offline mode is unavailable.', reason

app.templates.unsupportedBrowser = """
  <div class="_fail">
    <h1 class="_fail-title">申し訳ございませんが、ご使用のブラウザはサポートされていません。</h1>
    <p class="_fail-text">DevDocsがサポートしているブラウザ:
    <ul class="_fail-list">
      <li>Chrome と Firefox　の最新バージョン
      <li>Safari 5.1 以上
      <li>Opera 12.1　以上
      <li>Internet Explorer 10　以上
      <li>iOS 6 以上
      <li>Android 4.1 以上
      <li>Windows Phone 8　以上
    </ul>
    <p class="_fail-text">
      もしアップグレードできない場合は、申し訳ございません。
      古いブラウザにとって速く、新しい機能や、サポートの延長を優先で決定します。
    <p class="_fail-text">
      ノート：もし既にお使いのブラウザのバージョンが超えていれば、設定やアドオンを確認してください。
      アプリはブラウザを判別しています、ユーザーエージェントを参照していません。
    <p class="_fail-text">
      &mdash; Thibaut <a href="https://twitter.com/DevDocs" class="_fail-link">@DevDocs</a>
  </div>
"""
