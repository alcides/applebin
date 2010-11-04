#!/usr/bin/env ruby 
require 'rubygems'
require 'find'
require 'ftools'
require 'fileutils'
require 'erb'
require 'RedCloth'

# _tx2pdf (or whatever you feel like calling it) is a tool to convert
# all textile files in you path to html (and pdf if you use a Mac). 

# Written by Alcides Fonseca (http://alcidesfonseca.com) in 2009

# The following binary is the WebPageRendererCLITool by Sapo
# http://softwarelivre.sapo.pt/projects/mac/wiki/WebPageRendererCLITool
# You'll need to have it in your path

$binary = 'html2pdf'
 
def convert_to_textile(src)

  src_file = File.open(src)
  textiled = RedCloth.new src_file.read
  src_file.close

  content = textiled.to_html
  html = ERB.new(DATA.read).result(binding)

  dest_name = File.expand_path(src.sub('.textile', '.html'))
  
  dest_file = File.open( dest_name ,"w")
  dest_file.write html
  dest_file.close

  if `which #{$binary}` != ""
    final_name = src.sub('.textile', '.pdf')
    `#{$binary} --header-footer-textcolor FFFFFF --pdf #{final_name} file://#{dest_name}`
    `rm #{dest_name}` 
  end
end

def main
  Find.find("./") do |f|
    if f.include? ".textile"
      convert_to_textile f
    end
  end
end

main()

__END__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
  "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><title>Doc</title><style>
.clear{clear:both;}
h1{font-size:40pt;}
h2{margin-top:40px;}
body{padding:0;margin:0;font-family:"Lucida Grande","Calibri",Helvetica,Arial,Verdana,sans-serif;font-size:12pt;line-height:150%;width:738px;text-align:justify;}
pre{font-family:'Andale Mono','Lucida Console','Courier New',monospaced;font-size:10px;max-height:360px;overflow:auto;width:630px;}
code{font-family:'Courier New',Courier,Fixed;font-size:11px;font-style:normal;font-variant:normal;font-weight:normal;line-height:normal;}
blockquote{font-family:Georgia,serif;font-style:italic;}
a{text-decoration:none;color:#2A4753;}
a img{border:none;}
p{color:#333333;font-family:Helvetica,'Lucida Grande',Verdana,Arial,Sans-Serif;}
.footnote{font-size:8pt;}
.header{padding-bottom:10px;padding-top:10px;width:100%;border-bottom:solid #1C82CD 5px;text-align:center;}
</style></head>
<body><div class="content"><%= content %></div></body>
</html>