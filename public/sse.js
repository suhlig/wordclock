EventSource.prototype.byIndex = function(i){
  var ii = 0;

  for (var lbl in this){
    if (ii == i)
      return lbl;

    ii += 1;
  }
};

function initEventSource(attempt = 0) {
  var es = new EventSource(SSE_EVENTS_URL);
  console.info('Attempt #' + attempt + ' connecting to ' + es.url);

  es.onerror = function(e) {
    es.close();
    backoff = Math.pow(2, attempt++);
    console.log('Error establishing EventSource connection to '
      + es.url
      + '; current status is: '
      + es.byIndex(es.readyState)
      + '. Trying again in '
      + backoff + ' seconds'
    );

    setTimeout(initEventSource, 1000 * backoff, attempt);
  };

  es.onopen = function(e) {
    attempt = 0;
    console.log('Successfully established EventSource connection to ' + es.url);
  };

  es.onmessage = function(event) {
    var doc = JSON.parse(event.data);
    var li = document.createElement("li");
    li.appendChild(document.createTextNode(doc.time + ':' + doc.color));
    events = document.getElementById('events');
    events.insertBefore(li, events.firstChild);
  };
};

initEventSource();
