/*globals svgEditor*/

svgEditor.setConfig({
extensions: [
  // 'ext-server_opensave.js',
	// 'ext-eyedropper.js',
	// 'ext-shapes.js',
	// 'ext-polygon.js',
	// 'ext-star.js'
],
//emptyStorageOnDecline: true
	allowedOrigins: [window.location.origin], // May be 'null' (as a string) when used as a file:// URL
  showRulers: false,
  extPath: 'js/extensions/',
});
