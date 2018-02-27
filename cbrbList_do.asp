<%
'Copyright (C) Stefan Buchali, UDG United Digital Group, www.udg.de
'
'This software is licensed under a
'Creative Commons GNU General Public License (http://creativecommons.org/licenses/GPL/2.0/)
'Some rights reserved.
'
'You should have received a copy of the GNU General Public License
'along with cbrbList.  If not, see http://www.gnu.org/licenses/.

Response.ContentType = "text/html"
Response.Charset = "utf-8"

Server.ScriptTimeOut=300

'get session information
SessionKey=request.form("SessionKey")
RedakteurLoginGUID=request.form("RedakteurLoginGUID")
AktuelleSeiteGUID = request.form("AktuelleSeiteGUID")

' Eingaben holen
saveEltTemplateName=request.form("saveEltTemplateName")
savetype=request.form("savetype")
cbrbList = replace(request.form("cbrbList"),", ",",")

if savetype<>"txt" then
	cbrbList = replace(cbrbList,"&","&amp;")
	cbrbList = replace(cbrbList,"&amp;amp;","&amp;")
end if

if cbrbList="" then cbrbList="#"&SessionKey end if


	' XML-Verarbeitung per Microsoft-DOM vorbereiten
	set XMLDoc = Server.CreateObject("MSXML2.DOMDocument")
	XMLDoc.async = false
	XMLDoc.validateOnParse = false

	' RedDot Object fuer RQL-Zugriffe anlegen
	set objIO = Server.CreateObject("OTWSMS.AspLayer.PageData")

	' Variablendeklaration
	Dim xmlSendDoc		' RQL-Anfrage, die zum Server geschickt wird
	Dim ServerAnswer	' Antwort des Servers


	'Elemente der Seite auslesen
	xmlSendDoc=	"<IODATA loginguid=""" & RedakteurLoginGUID & """ sessionkey=""" & SessionKey & """ dialoglanguageid=""DEU"">"&_
					"<PAGE guid=""" & AktuelleSeiteGUID & """>"&_
						"<ELEMENTS action=""load"" />"&_
					"</PAGE>"&_
				"</IODATA>"
	ServerAnswer = objIO.ServerExecuteXml (xmlSendDoc, sError)
	XMLDoc.loadXML(ServerAnswer)
	saveEltGuid = XMLDoc.selectsinglenode("//ELEMENT/@guid[../@name='" & saveEltTemplateName & "']").text


	'Eingaben speichern
	if savetype="txt" then
		xmlSendDoc=	"<IODATA format=""1"" loginguid=""" & RedakteurLoginGUID & """ sessionkey=""" & SessionKey & """>"&_
						"<ELT action=""save"" guid=""" & saveEltGuid & """ type=""32"">" & Server.HTMLEncode(cbrbList) & "</ELT>"&_
					"</IODATA>"
	else
		xmlSendDoc=	"<IODATA loginguid=""" & RedakteurLoginGUID & """ sessionkey=""" & SessionKey & """>"&_
						"<ELEMENTS action=""save"" reddotcacheguid="""">"&_
							"<ELT guid=""" & saveEltGuid & """ type=""1"" value=""" & cbrbList & """/>"&_
						"</ELEMENTS>"&_
					"</IODATA>"
	end if
	ServerAnswer = objIO.ServerExecuteXml (xmlSendDoc, sError)



set objIO = nothing
set XMLDoc = nothing

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>cbrbList</title>
</head>
<body onload="opener.location.reload();self.close()">
</body>
</html>