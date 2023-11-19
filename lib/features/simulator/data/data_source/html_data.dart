abstract class HtmlData {
  static String getHtmlData({String currency = "EURUSD"}) {
    return '''
    <div class="tradingview-widget-container" 
      style="height:calc(100%);width:100%">
        <div id="tradingview_e679c" style="height:calc(100% - 32px);width:100%"></div>
        <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"></a></div>
        <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
        <script type="text/javascript">
        new TradingView.widget(
        {
        "autosize": true,
        "dateRange": "12m",
        "symbol": "OANDA:$currency",
        "interval": "D",
        "timezone": "Etc/UTC",
        "theme": "dark",
        "style": "1",
        "locale": "en",
        "enable_publishing": false,
        "hide_top_toolbar": true,
        "hide_legend": true,
        "save_image": false,
        "hide_volume": true,
        "container_id": "tradingview_e679c"
      }
        );
        </script>
      </div>
''';
  }
}
