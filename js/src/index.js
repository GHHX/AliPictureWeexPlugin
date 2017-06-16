

const WeexPluginWheelPicker = {
  show() {
      alert("module WeexPluginWheelPicker is created sucessfully ")
  }
};


var meta = {
   WeexPluginWheelPicker: [{
    name: 'show',
    args: []
  }]
};



if(window.Vue) {
  weex.registerModule('WeexPluginWheelPicker', WeexPluginWheelPicker);
}

function init(weex) {
  weex.registerApiModule('WeexPluginWheelPicker', WeexPluginWheelPicker, meta);
}
module.exports = {
  init:init
};
