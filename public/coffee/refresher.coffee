$ ->
	console.log 'REFRESHER!'
	setTimeout ->
	  window.location.reload(true)
	, 10000