/*global window */
/*global document */
/*eslint no-unused-vars: off */


/**************************** prototype注入 ****************************/

/* 对给定的属性名进行值的设定 */
window.Element.prototype.setAttributeWithNodeValue = function (attributeName, nodeValue) {
    
    'use strict';
    this.setAttribute(attributeName, nodeValue);
};

/* 根据属性值获取属性的node值,存在这个属性则返回字符串,如果不存在这个属性,则返回undefined */
window.Element.prototype.getNodeValueByAttribute = function (attributeName) {
    
    'use strict';
    var ret;
    
    if (this.attributes[attributeName] !== undefined) {
        
        ret = this.attributes[attributeName].nodeValue;
    }
    
    return ret;
};

/* 获取当前节点下的所有子节点,返回元素数组 */
window.Element.prototype.getAllSubElements = function () {
    
    'use strict';
    return this.querySelectorAll("*");
};

/* 通过给定的属性名,以及数值的数组,返回查询出来的匹配的元素数组 */
window.Element.prototype.getSubElementsDictionaryByAttributeAndValues = function (attributeName, values) {
    
    'use strict';
    var elements = this.querySelectorAll("*");
    var dic = [];
    
    for (var i = 0; i < values.length; i++) {
        
        var string = values[i];
        
        for (var j = 0; j < elements.length; j++) {
            
            var tmp = elements[j];
            
            if (tmp.attributes[attributeName] !== undefined && tmp.attributes[attributeName].nodeValue === string) {
                
                dic[string] = tmp;
                break;
            }
        }
    }
    
    return dic;
};

/**************************** 原子操作 ****************************/

/* 将消息发送到客户端 */
function postMessageToApp(string) {
    
    window.webkit.messageHandlers.AppModel.postMessage(string);
}

/**************************** 初始化操作 ****************************/

function addClickEvent() {
    
    // 获取body中id为content的div
    var childNodes = document.getElementById("container").childNodes;
    
    for (var i = 0; i < childNodes.length; i++) {
        
        // 获取节点
        var element = childNodes[i];
        
        // 筛选出div
        if (element.tagName === 'DIV') {
            
            var idName = element.getNodeValueByAttribute("ID");
            
            // 筛选出前缀为ws_的div
            if (idName.includes('ws_') === true) {
                
                // 添加点击事件
                element.onclick = function () {
                    
                    APP_CALL_THIS_getDivInfoById(this.attributes['id'].nodeValue);
                };
            }
        }
    }
}

/**************************** APP端调用 ****************************/

var Function_IsShowDebugFrame = "APP_CALL_THIS_isShowDebugFrame";
var Function_SetShowDebugFrame = "APP_CALL_THIS_setShowDebugFrame";
var Function_GetDivInfoById = "APP_CALL_THIS_getDivInfoById";
var Function_SetDivInfoById = "APP_CALL_THIS_setDivInfoById";
var Function_SetBodyInfo = "APP_CALL_THIS_setBodyInfo";

/* 当前是否显示debug */
function APP_CALL_THIS_isShowDebugFrame() {
    
    var element = document.body;
    
    // 将结果返回给app
    postMessageToApp({
                     function: Function_IsShowDebugFrame,
                     parameters: [],
                     data: element.classList.contains("outline")
                     });
}

/* 是否显示debugFrame,给定 true 或者 false */
function APP_CALL_THIS_setShowDebugFrame(showOrNot) {
    
    var element = document.body;
    
    if (showOrNot === true) {
        
        element.className = element.className + " outline";
        
    } else {
        
        element.className = element.className.replace(" outline", "");
    }
    
    // 将结果返回给app
    postMessageToApp({
                     function: Function_SetShowDebugFrame,
                     parameters: [showOrNot],
                     data: element.classList.contains("debug")
                     });
}

/* 根据id获取div配置信息 */
function APP_CALL_THIS_getDivInfoById(id) {
    
    // 将结果返回给app
    postMessageToApp({
                     function: Function_GetDivInfoById,
                     parameters: [id]
                     });
}

/* 根据id以及json数据配置div */
function APP_CALL_THIS_setDivInfoById(id, json) {
    
    var element = document.getElementById(id);
    var obj = JSON.parse(json);
    
    if (element !== undefined && obj !== undefined) {
        
        var subDictionary = obj["sub"];
        var elements = element.getAllSubElements();
        
        element.setAttributeWithNodeValue("class", obj["class"]);
        element.setAttributeWithNodeValue("style", obj["style"]);
        
        for (var i = 0; i < elements.length; i++) {
            
            /* 获取sub中的子元素 */
            var subElement = elements[i];
            
            /* 从子元素中获取tag中的值 */
            var tag = subElement.getNodeValueByAttribute("tag");
            
            /* 从字典中获取该tag对应的配置文件 */
            var set = subDictionary[tag];
            
            for (var attribute in set) {
                
                /* 对sub子元素进行值的设定 */
                subElement.setAttributeWithNodeValue(attribute, set[attribute]);
            }
        }
        
        // 将结果返回给app
        postMessageToApp({
                         function: Function_SetDivInfoById,
                         parameters: [id],
                         data: json
                         });
    }
}

/* 设置body的信息 */
function APP_CALL_THIS_setBodyInfo(json) {
    
    var obj = JSON.parse(json);
    
    if (obj !== undefined) {
        
        for (var idName in obj) {
            
            var element = document.getElementById(idName);
            var set = obj[idName];
            element.setAttributeWithNodeValue("class", set["class"]);
            element.setAttributeWithNodeValue("style", set["style"]);
        }
        
        // 将结果返回给app
        postMessageToApp({
                         function: Function_SetBodyInfo,
                         parameters: [],
                         data: json
                         });
    }
}
