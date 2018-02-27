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

'get session information
SessionKey=request.form("Sessionkey")
RedakteurLoginGUID=request.form("LoginGUID")
AktuelleSeiteGUID = request.form("PageGUID")

if SessionKey="" then
	SessionKey=Session("SessionKey")
end if
if RedakteurLoginGUID="" then
	RedakteurLoginGUID=Session("LoginGUID")
end if
if AktuelleSeiteGUID="" then
	AktuelleSeiteGUID = Session("PageGUID")
end if

'get the required parameters
allItems=request.form("allItems")
selectedItems=request.form("selectedItems")
saveEltTemplateName=request.form("saveEltTemplateName")

'get the optional parameters
pluginTitle=request.form("pluginTitle")
eltDescription=request.form("eltDescription")
cbrbtype=request.form("cbrbtype")
savetype=request.form("savetype")

'set the optional parameters to default, if empty
if pluginTitle="" then pluginTitle="Element bearbeiten" end if
if eltDescription="" then eltDescription="Bitte w&auml;hlen" end if
if cbrbtype="" then cbrbtype="checkbox" end if
if savetype="" then savetype="std" end if

'predefine variables
listString=""
count=0

'set the fieldset flag to "false"
fieldsets=false

for each singleItem in split(allItems,",")

	'In case of a fieldset create fieldset and legend tag, and set the fieldset flag to "true"
	if left(trim(singleItem),9)="fieldset:" then
		
		'first, close a previous fieldset, if existing (marked by the fieldset flag)
		if fieldsets then listString=listString&"</fieldset>" end if

		fieldsets=true
		arrFieldset = split(singleItem,":")
		listString=listString&"<fieldset><legend>" & arrFieldset(1) & "</legend>"

	'Otherwise create the input field and label
	else
		count=count+1
		if inStr(singleItem,"|") then
			arrSingleItem = split(singleItem,"|")
			itemValue=trim(arrSingleItem(0))
			itemLabel=trim(arrSingleItem(1))
		else
			itemValue=trim(singleItem)
			itemLabel=trim(singleItem)
		end if
		listString=listString&"<input type="""&cbrbtype&""" name=""cbrbList"" id=""cbrbList"&count&""" value="""&itemValue&""""
		if cbrbtype="checkbox" then
            if inStr("," &selectedItems& ",", "," &itemValue& ",")>0 then
                listString=listString&" checked=""checked"""
            end if
        else
		if selectedItems=itemValue then
				listString=listString&" checked=""checked"""
			end if
		end if
		listString=listString&" /><label for=""cbrbList"&count&""">"&itemLabel&"</label><br />"&vbcrlf
	end if
next

'close the last fieldset, if existing (marked by the fieldset flag)
if fieldsets then listString=listString&"</fieldset>" end if

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../../stylesheets/ioStyleSheet.css" />
<style type="text/css">
	button {
		border: 1px solid black;
		background: #EEEEEE;
	}
	fieldset {
		margin-bottom: 1em;
		padding: 0.5em 0;
	}
	legend {
		font-weight: bold;
	}
</style>
<script type="text/javascript">
var submitOK=true;

function absenden() {
	if(submitOK) {
		submitOK=false;
		document.getElementById("btn1").disabled=true;
		document.getElementById("btn2").disabled=true;
		document.cbrbForm.submit();
	}
}
</script>
<title><%=pluginTitle %></title>
</head>
<body link="navy" alink="navy" vlink="navy" bgcolor="#ffffff" background="../../icons/back5.gif">
<form name="cbrbForm" method="post" action="cbrbList_do.asp">
<input type="hidden" name="saveEltTemplateName" value="<%= saveEltTemplateName %>" />
<input type="hidden" name="SessionKey" value="<%= SessionKey %>" />
<input type="hidden" name="RedakteurLoginGUID" value="<%= RedakteurLoginGUID %>" />
<input type="hidden" name="AktuelleSeiteGUID" value="<%= AktuelleSeiteGUID %>" />
<input type="hidden" name="savetype" value="<%= savetype %>" />
<table class="tdgrey" border="0" align="center" width="400" cellspacing="0" cellpadding="3">
<tr>
<td width="100%">
	<table class="tdgreylight" border="0" width="100%" cellspacing="0" cellpadding="1">
	<tr>
	<td width="100%" align="left" valign="top" height="50">
		<table border="0" width="100%">
		<tr><td class="titlebar" width="100%"><%=pluginTitle %></td></tr>
		</table>
	</td>
	</tr>
	<tr>
	<td width="100%" align="left" valign="top" height="80">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		<td align="left" valign="top" class="label" width="100%"><%= eltDescription %></td>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		</tr>
		<tr>
		<td height="5" colspan="3"></td>
		</tr>
		<tr>
		<td></td>
		<td class="normal"><%=listString%></td>
		<td></td>
		</tr>
		<tr>
		<td height="20" colspan="3"><img src="../../icons/transparent.gif" width="1" height="20" border="0" alt=""></td>
		</tr>
		<tr>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		<td align="right" valign="top"><button id="btn1" type="button" onclick="absenden()">OK</button>&nbsp;&nbsp;<button id="btn2" type="button" onclick="self.close()">Abbrechen</button></td>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		</tr>
		<tr>
		<td height="15" colspan="3"></td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>
</form>

</body>
</html>