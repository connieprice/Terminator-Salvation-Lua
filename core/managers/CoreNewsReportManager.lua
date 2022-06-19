core:module("CoreNewsReportManager")
core:require_module("CoreClass")
core:require_module("CoreString")
NewsReportManager = NewsReportManager or CoreClass.class()
NewsReportManager.NEWS_FILE = "data/settings/news.xml"
NewsReportManager.OLD_NEWS_FILE = "data/settings/old_news.xml"
NewsReportManager.KEYWORDS = {
	SP = " ",
	TB = "\t",
	NL = "\n",
	GRIN_URL = "http://www.grin.se",
	GANON_URL = "http://ganonbackup",
	WIKI_URL = "http://ganonbackup/wiki_artistwiki/index.php/Main_Page",
	CT_WIKI_URL = "http://ganonbackup/wiki_artistwiki/index.php/Core_Team",
	GRIN = [[

  _|_|_|  _|_|_|    _|_|_|  _|      _|
_|        _|    _|    _|    _|_|    _|
_|  _|_|  _|_|_|      _|    _|  _|  _|
_|    _|  _|    _|    _|    _|    _|_|
  _|_|_|  _|    _|  _|_|_|  _|      _|
]],
	ENV = {
		os.getenv,
		true
	}
}
function NewsReportManager.init(A0_0)
	A0_0._news_dates = {}
	if File:config_exists(A0_0.NEWS_FILE) then
		if not File:config_exists(A0_0.OLD_NEWS_FILE) then
			assert(File:open(A0_0.OLD_NEWS_FILE, "w")):write("<old_news/>")
			assert(File:open(A0_0.OLD_NEWS_FILE, "w")):close()
		else
			for 