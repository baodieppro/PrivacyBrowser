
let parsedFilterData = {};
parse(easyListTxt, parsedFilterData);
let parsedFilterDataPrivacy = {};
parse(easyListPrivacyTxt, parsedFilterDataPrivacy);

document.addEventListener("beforeload", function(event) {
  let urlToCheck = event.url;
  let currentPageDomain = document.location.hostname;
  let config = {
      domain: currentPageDomain,
      elementTypeMaskMap: elementTypes.SCRIPT
  };

  if (currentPageDomain == "duckduckgo.com") {
      // TODO (ISSUE): Figure out why it's blocking DuckDuckGo
  } else if (matches(parsedFilterData, urlToCheck, config)) {
      webkit.messageHandlers.trackerDetected.postMessage(event.url);
      event.preventDefault();
  } else if (matches(parsedFilterDataPrivacy, urlToCheck, config)) {
      webkit.messageHandlers.trackerDetected.postMessage(event.url);
      event.preventDefault();
  } else {
      webkit.messageHandlers.resourceAllowed.postMessage(event.url);
  }
}, true);
