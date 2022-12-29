<%@ Language = "Python" %>
<!--#include file="..\..\..\..\timetree\bin\asp\lib\MSXMLGate.py.asp"-->
<!--#include file="..\..\..\..\timetree\bin\asp\lib\MSFORMGate.py.asp"-->
<!--#include file="..\..\..\..\timetree\bin\asp\lib\MySQLGate.py.asp"-->
<!--#include file="..\..\..\..\timetree\bin\asp\lib\UTILITYGate.py.asp"-->
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
		<meta http-equiv="Expires" content="-1">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="PRAGMA" content="NO-CACHE">
		<meta content="INDEX,NOFOLLOW" name="robots">
	<head>
	<body>
<%
import TimeTree2
start = utilitygate.getStart()

ID = 0
if str(Request.QueryString("tool_id")) <> "" and str(Request.QueryString("tool_id")) <> "None":
	ID = int(Request.QueryString("tool_id"))

rnumber = ""
if str(Request.QueryString("rnumber")) <> "" and str(Request.QueryString("rnumber")) <> "None":
	rnumber = str(Request.QueryString("rnumber"))

requests = None
cachepath="C:/projects/grafik2/machine/cache/crm/"
output = utilitygate.readCache(cachepath)
output2 = ""

if output == None:
	sqlgate.cn = sqlgate.open("dsn=crm_grafik;uid=root;pwd=securemarc")
	sqlgate.cn2 = "dsn=_crm_grafik;uid=;pwd="
	requests = TimeTree2.crm.Requests(utilitygate=utilitygate, xmlgate=xmlgate, sqlgate=sqlgate, formgate=formgate, session=Session.SessionID, user="abh", appname="grafik2", cachepath=cachepath, project="grafik2")
	requests.patterns[54] = "C:/timetree/templates/application/crm/crm_report"+rnumber

	output = requests.tools[ID].output(ID)
	utilitygate.writeCache(cachepath,output)

if not requests:
	if ",None,,".find(","+str(formgate.urlParse("idx"))+",") == -1:
		formgate.setSession("timetreeaidx",str(formgate.urlParse("idx")))
	sqlgate.cn = sqlgate.open("dsn=crm_grafik;uid=root;pwd=securemarc")
	sqlgate.cn2 = "dsn=_crm_grafik;uid=;pwd="
	requests = TimeTree2.crm.Requests(utilitygate=utilitygate, xmlgate=xmlgate, sqlgate=sqlgate, formgate=formgate, session=Session.SessionID, user="abh", appname="grafik2", cachepath=cachepath, project="grafik2")

output2 = requests.tools[72].output(72)

utilitygate.getTimeControl(start,"Celkem: ")

output = (output + output2).replace("]][[","],[").replace("[]","")
%>
		<script type="text/javascript">
		<!--
		window.parent.RPC.fill(<%=output%>);
		-->
		</script>
	</body>
</html>