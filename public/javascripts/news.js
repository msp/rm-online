google.load("feeds", "1");

function feedLoaded(result) {
  if (!result.error) {

    var content = document.getElementById('feed-content');
    content.innerHTML = '';

    var items = result.xmlDocument.getElementsByTagName('item');

    htmlBuffer = "";
    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      var title = item.getElementsByTagName('title')[0].firstChild.nodeValue;
      var description = item.getElementsByTagName('description')[0].firstChild.nodeValue;
      var guid = item.getElementsByTagName('guid')[0].firstChild.nodeValue;

      htmlBuffer += "<tr class=\"news-item\"><td>";
      htmlBuffer += "<h3><a href=\""+guid+"\">"+title+"</a></h3>";
      //htmlBuffer += description;
      //htmlBuffer += "<br/><br/><br/><br/>";
      htmlBuffer += "</td></tr>";
    }

    content.innerHTML = htmlBuffer;
  }
}


function bootAngular() {
  // do this in partial for Angular
  jsapiOnLoad();
  //angular.element(document).ready(function() {
  //  angular.bootstrap(document, ['rmOnlineApp']);
  //});
}

function jsapiOnLoad() {
  var feed = new google.feeds.Feed("http://www.experian.com/blogs/news/feed/");
  feed.setResultFormat(google.feeds.Feed.XML_FORMAT);
  feed.includeHistoricalEntries();
  feed.setNumEntries(6);
  feed.load(feedLoaded);
}

google.setOnLoadCallback(bootAngular);
