$(document).ready(function(){	
	var ad1 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'Benefits of a Repo Manager\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'Benefits of a Repo Manager\',\'1\']);" href="http://www.sonatype.com/resources/whitepapers/the-benefits-of-utilizing-a-repository-manager?utm_source=Book%20Ads&utm_medium=Sidebar%20Click&utm_content=Benefits%20of%20a%20Repo%20Manager&utm_campaign=Book%20Ads%20-%20Benefits%20of%20a%20Repo%20Manager" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMTcvMjEvNDIvMTMvMTAwL0JlbmVmaXRzX1JlcG9fTWFuYWdlci5wbmciXV0/Benefits-Repo-Manager.png" />' +
				'</a>',
		ad2 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'Nexus Free Trial\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'Nexus Free Trial\',\'1\']);" href="http://www.sonatype.com/nexus/free-trial?utm_source=Book%20Ads&utm_medium=Sidebar%20Click&utm_content=Nexus%20Free%20Trial&utm_campaign=Book%20Ads%20-%20Nexus%20Free%20Trial" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMDYvMDcvMTEvMjMvMjgzL00yX05leHVzX1Byb190cmlhbC5wbmciXV0/M2-Nexus-Pro-trial.png" />' +
				'</a>',
		ad3 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'Application Healthcheck\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'Application Healthcheck\',\'1\']);"  href="http://www.sonatype.com/application-health-check?utm_source=Book%20Ads&utm_medium=Sidebar%20Click&utm_content=Application%20Healthcheck&utm_campaign=Book%20Ads%20-%20Application%20Healthcheck" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMDYvMDcvMTEvMjQvODc1L00zX0Fzc2Vzc21lbnRfaGVhbHRoY2hlY2sucG5nIl1d/M3-Assessment-healthcheck.png" />' +
				'</a>',
		ad4 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'Nexus to CLM Whitepaper\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'Nexus to CLM Whitepaper\',\'1\']);"  href="http://img.en25.com/Web/SonatypeInc/{5e132858-9f8a-4f39-a090-e314c914dd6e}_Nexus_to_CLM_final.pdf" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMDYvMDcvMTEvMjUvOTAwL04xX05leHVzX3RvX0NMTV9XUC5wbmciXV0/N1-Nexus-to-CLM-WP.png" />' +
				'</a>',
		ad5 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'OWASP Whitepaper\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'OWASP Whitepaper\',\'1\']);"  href="http://img.en25.com/Web/SonatypeInc/%7B07d14ce8-63a4-4b19-a0c7-c7a9586e73a9%7D_OWASP_Whitepaper_Final_(1).pdf" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMDYvMDcvMTEvMjUvMzM3L04yX09XQVNQX1dQLnBuZyJdXQ/N2-OWASP-WP.png" />' +
				'</a>',
		ad6 = 	'<a onclick="_gaq.push([\'_trackEvent\',\'Book Ad\',\'Click\',\'CLM Product Tour\',\'1\']);_gaq.push([\'cdt._trackEvent\',\'Book Ad\',\'Click\',\'CLM Product Tour\',\'1\']);"  href="http://www.sonatype.com/take-a-tour/clm-tour?utm_source=Book%20Ads&utm_medium=Sidebar%20Click&utm_content=CLM%20Product%20Tour&utm_campaign=Book%20Ads%20-%20CLM%20Product%20Tour" target="_blank" class="book-ad">' +
				'<img src="http://www.sonatype.com/system/images/W1siZiIsIjIwMTQvMDEvMDYvMDcvMTEvMjUvNDE0L04zX0NMTV9wcm9kdWN0X3RvdXIucG5nIl1d/N3-CLM-product-tour.png" />' +
				'</a>';
	var newline = '<br/><br/>';
	var adsMaven = newline + ad1 + newline + ad2 + newline + ad3;
	var adsNexus = newline + ad4 + newline + ad5 + newline + ad6;
	$('body.ss-book-mvnex #sidebar').append(adsMaven);
	$('body.ss-book-mvnref #sidebar').append(adsMaven);
	$('body.ss-book-nxbook #sidebar').append(adsNexus);
})