/*
 Highcharts JS v2.3.3 (2012-10-04)
 Exporting module

 (c) 2010-2011 Torstein Hønsi

 License: www.highcharts.com/license
*/
(function(){function e(e){for(var t=e.length;t--;)typeof e[t]=="number"&&(e[t]=Math.round(e[t])-.5);return e}var t=Highcharts,n=t.Chart,r=t.addEvent,i=t.removeEvent,s=t.createElement,o=t.discardElement,u=t.css,a=t.merge,f=t.each,l=t.extend,c=Math.max,h=document,p=window,d=h.documentElement.ontouchstart!==void 0,v=t.getOptions();l(v.lang,{downloadPNG:"Download PNG image",downloadJPEG:"Download JPEG image",downloadPDF:"Download PDF document",downloadSVG:"Download SVG vector image",exportButtonTitle:"Export to raster or vector image",printButtonTitle:"Print the chart"}),v.navigation={menuStyle:{border:"1px solid #A0A0A0",background:"#FFFFFF"},menuItemStyle:{padding:"0 5px",background:"none",color:"#303030",fontSize:d?"14px":"11px"},menuItemHoverStyle:{background:"#4572A5",color:"#FFFFFF"},buttonOptions:{align:"right",backgroundColor:{linearGradient:[0,0,0,20],stops:[[.4,"#F7F7F7"],[.6,"#E3E3E3"]]},borderColor:"#B0B0B0",borderRadius:3,borderWidth:1,height:20,hoverBorderColor:"#909090",hoverSymbolFill:"#81A7CF",hoverSymbolStroke:"#4572A5",symbolFill:"#E0E0E0",symbolStroke:"#A0A0A0",symbolX:11.5,symbolY:10.5,verticalAlign:"top",width:24,y:10}},v.exporting={type:"image/png",url:"http://export.highcharts.com/",width:800,buttons:{exportButton:{symbol:"exportIcon",x:-10,symbolFill:"#A8BF77",hoverSymbolFill:"#768F3E",_id:"exportButton",_titleKey:"exportButtonTitle",menuItems:[{textKey:"downloadPNG",onclick:function(){this.exportChart()}},{textKey:"downloadJPEG",onclick:function(){this.exportChart({type:"image/jpeg"})}},{textKey:"downloadPDF",onclick:function(){this.exportChart({type:"application/pdf"})}},{textKey:"downloadSVG",onclick:function(){this.exportChart({type:"image/svg+xml"})}}]},printButton:{symbol:"printIcon",x:-36,symbolFill:"#B5C9DF",hoverSymbolFill:"#779ABF",_id:"printButton",_titleKey:"printButtonTitle",onclick:function(){this.print()}}}},l(n.prototype,{getSVG:function(e){var t=this,n,r,i,u=a(t.options,e);return h.createElementNS||(h.createElementNS=function(e,t){return h.createElement(t)}),e=s("div",null,{position:"absolute",top:"-9999em",width:t.chartWidth+"px",height:t.chartHeight+"px"},h.body),l(u.chart,{renderTo:e,forExport:!0}),u.exporting.enabled=!1,u.chart.plotBackgroundImage=null,u.series=[],f(t.series,function(e){i=a(e.options,{animation:!1,showCheckbox:!1,visible:e.visible}),i.isInternal||(i&&i.marker&&/^url\(/.test(i.marker.symbol)&&(i.marker.symbol="circle"),u.series.push(i))}),n=new Highcharts.Chart(u),f(["xAxis","yAxis"],function(e){f(t[e],function(t,r){var i=n[e][r],s=t.getExtremes(),o=s.userMin,s=s.userMax;(o!==void 0||s!==void 0)&&i.setExtremes(o,s,!0,!1)})}),r=n.container.innerHTML,u=null,n.destroy(),o(e),r=r.replace(/zIndex="[^"]+"/g,"").replace(/isShadow="[^"]+"/g,"").replace(/symbolName="[^"]+"/g,"").replace(/jQuery[0-9]+="[^"]+"/g,"").replace(/isTracker="[^"]+"/g,"").replace(/url\([^#]+#/g,"url(#").replace(/<svg /,'<svg xmlns:xlink="http://www.w3.org/1999/xlink" ').replace(/ href=/g," xlink:href=").replace(/\n/," ").replace(/<\/svg>.*?$/,"</svg>").replace(/&nbsp;/g," ").replace(/&shy;/g,"­").replace(/<IMG /g,"<image ").replace(/height=([^" ]+)/g,'height="$1"').replace(/width=([^" ]+)/g,'width="$1"').replace(/hc-svg-href="([^"]+)">/g,'xlink:href="$1"/>').replace(/id=([^" >]+)/g,'id="$1"').replace(/class=([^" ]+)/g,'class="$1"').replace(/ transform /g," ").replace(/:(path|rect)/g,"$1").replace(/style="([^"]+)"/g,function(e){return e.toLowerCase()}),r=r.replace(/(url\(#highcharts-[0-9]+)&quot;/g,"$1").replace(/&quot;/g,"'"),r.match(/ xmlns="/g).length===2&&(r=r.replace(/xmlns="[^"]+"/,"")),r},exportChart:function(e,t){var n,r=this.getSVG(a(this.options.exporting.chartOptions,t)),e=a(this.options.exporting,e);n=s("form",{method:"post",action:e.url,enctype:"multipart/form-data"},{display:"none"},h.body),f(["filename","type","width","svg"],function(t){s("input",{type:"hidden",name:t,value:{filename:e.filename||"chart",type:e.type,width:e.width,svg:r}[t]},null,n)}),n.submit(),o(n)},print:function(){var e=this,t=e.container,n=[],r=t.parentNode,i=h.body,s=i.childNodes;e.isPrinting||(e.isPrinting=!0,f(s,function(e,t){e.nodeType===1&&(n[t]=e.style.display,e.style.display="none")}),i.appendChild(t),p.print(),setTimeout(function(){r.appendChild(t),f(s,function(e,t){e.nodeType===1&&(e.style.display=n[t])}),e.isPrinting=!1},1e3))},contextMenu:function(e,t,n,i,o,a){var h=this,p=h.options.navigation,v=p.menuItemStyle,m=h.chartWidth,g=h.chartHeight,y="cache-"+e,b=h[y],w=c(o,a),E,S;b||(h[y]=b=s("div",{className:"highcharts-"+e},{position:"absolute",zIndex:1e3,padding:w+"px"},h.container),E=s("div",null,l({MozBoxShadow:"3px 3px 10px #888",WebkitBoxShadow:"3px 3px 10px #888",boxShadow:"3px 3px 10px #888"},p.menuStyle),b),S=function(){u(b,{display:"none"})},r(b,"mouseleave",S),f(t,function(e){if(e){var t=s("div",{onmouseover:function(){u(this,p.menuItemHoverStyle)},onmouseout:function(){u(this,v)},innerHTML:e.text||h.options.lang[e.textKey]},l({cursor:"pointer"},v),E);t[d?"ontouchstart":"onclick"]=function(){S(),e.onclick.apply(h,arguments)},h.exportDivElements.push(t)}}),h.exportDivElements.push(E,b),h.exportMenuWidth=b.offsetWidth,h.exportMenuHeight=b.offsetHeight),e={display:"block"},n+h.exportMenuWidth>m?e.right=m-n-o-w+"px":e.left=n-w+"px",i+a+h.exportMenuHeight>g?e.bottom=g-i-w+"px":e.top=i+a-w+"px",u(b,e)},addButton:function(e){function t(){h.attr(v),c.attr(d)}var n=this,r=n.renderer,i=a(n.options.navigation.buttonOptions,e),s=i.onclick,o=i.menuItems,u=i.width,f=i.height,c,h,p,e=i.borderWidth,d={stroke:i.borderColor},v={stroke:i.symbolStroke,fill:i.symbolFill},m=i.symbolSize||12;n.exportDivElements||(n.exportDivElements=[],n.exportSVGElements=[]),i.enabled!==!1&&(c=r.rect(0,0,u,f,i.borderRadius,e).align(i,!0).attr(l({fill:i.backgroundColor,"stroke-width":e,zIndex:19},d)).add(),p=r.rect(0,0,u,f,0).align(i).attr({id:i._id,fill:"rgba(255, 255, 255, 0.001)",title:n.options.lang[i._titleKey],zIndex:21}).css({cursor:"pointer"}).on("mouseover",function(){h.attr({stroke:i.hoverSymbolStroke,fill:i.hoverSymbolFill}),c.attr({stroke:i.hoverBorderColor})}).on("mouseout",t).on("click",t).add(),o&&(s=function(){t();var e=p.getBBox();n.contextMenu("export-menu",o,e.x,e.y,u,f)}),p.on("click",function(){s.apply(n,arguments)}),h=r.symbol(i.symbol,i.symbolX-m/2,i.symbolY-m/2,m,m).align(i,!0).attr(l(v,{"stroke-width":i.symbolStrokeWidth||1,zIndex:20})).add(),n.exportSVGElements.push(c,p,h))},destroyExport:function(){var e,t;for(e=0;e<this.exportSVGElements.length;e++)t=this.exportSVGElements[e],t.onclick=t.ontouchstart=null,this.exportSVGElements[e]=t.destroy();for(e=0;e<this.exportDivElements.length;e++)t=this.exportDivElements[e],i(t,"mouseleave"),this.exportDivElements[e]=t.onmouseout=t.onmouseover=t.ontouchstart=t.onclick=null,o(t)}}),t.Renderer.prototype.symbols.exportIcon=function(t,n,r,i){return e(["M",t,n+r,"L",t+r,n+i,t+r,n+i*.8,t,n+i*.8,"Z","M",t+r*.5,n+i*.8,"L",t+r*.8,n+i*.4,t+r*.4,n+i*.4,t+r*.4,n,t+r*.6,n,t+r*.6,n+i*.4,t+r*.2,n+i*.4,"Z"])},t.Renderer.prototype.symbols.printIcon=function(t,n,r,i){return e(["M",t,n+i*.7,"L",t+r,n+i*.7,t+r,n+i*.4,t,n+i*.4,"Z","M",t+r*.2,n+i*.4,"L",t+r*.2,n,t+r*.8,n,t+r*.8,n+i*.4,"Z","M",t+r*.2,n+i*.7,"L",t,n+i,t+r,n+i,t+r*.8,n+i*.7,"Z"])},n.prototype.callbacks.push(function(e){var t,n=e.options.exporting,i=n.buttons;if(n.enabled!==!1){for(t in i)e.addButton(i[t]);r(e,"destroy",e.destroyExport)}})})();