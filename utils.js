function preUseCheck() {
  // 使用预检
  if (navigator.requestMediaKeySystemAccess) {
    return true;
  }
  log(
    "EME API is not supported. Enable pref media.eme.enabled to true in about:config"
  );
  return false;
}

// MediaSource readyState 属性
// closed 当前 ms 并未绑定到一个媒体元素上
// open 当前 ms 已绑定到一个媒体元素, 并准备好接收接收 SourceBuffer 对象
// ended 当前 ms 已绑定到一个媒体元素, 但流已经被 MediaSource.endOfStream() 结束

// MediaSource 对象事件
// // ms 对象未绑定到媒体元素时
// "sourceclosed",
// // ms 对象已经绑定到媒体元素, 且准备好添加缓冲区时 (此时 ms.readyState 属性为 open)
// "sourceopen",
// // 所有数据接收完成后触发
// "sourceended",

// SourceBuffer 对象事件
// // sb 对象的 updating 属性从 false 变更为 true 时触发
// "updatestart",
// // sb.appendBuffer/remove 方法完成时, 且 updating 已从 true 变更为 false 时触发, 在 updateend 事件之前执行
// "update",
// // sb.appendBuffer/remove 方法结束时, 且在 update 事件触发后再触发
// "updateend",


const VIDEO_EVENTS = [
  // 在文件开始加载且未实际加载任何数据前
  "loadstart",
  // 	当媒介长度改变时
  "durationchange",
  // 当元数据（比如分辨率和时长）被加载时
  "loadedmetadata",
  // 当媒介数据已加载时
  "loadeddata",
  // 当浏览器正在获取媒介数据时
  "progress",
  // 当文件就绪可以开始播放时（缓冲已足够开始时）
  "canplay",
  // 当媒介能够无需因缓冲而停止即可播放至结尾时
  "canplaythrough",

  // 媒体已加密时
  "encrypted",
  // 当媒介已到达结尾时
  "ended",
  // 当在文件加载期间发生错误时
  "error",
  // 当媒介被用户或程序暂停时
  "pause",
  // 当媒介已就绪可以开始播放时
  "play",
  // 当媒介已开始播放时
  "playing",
  // 在浏览器不论何种原因未能取回媒介数据时
  "stalled",
  // 在媒介数据完全加载之前不论何种原因终止取回媒介数据时
  "suspend",
  // 当媒介已停止播放但打算继续播放时（比如当媒介暂停已缓冲更多数据）
  "waiting",
];

function dispatchEvents(target, name, events) {
  // 事件分发
  // Log events dispatched to make debugging easier...
  events.forEach(function (e) {
    target.addEventListener(
      e,
      function (event) {
        log(`${name} 事件 ---> ${e}`);
      },
      false
    );
  });
}

function downloadProgress(id) {
  return function (percent) {
    e(id).innerHTML = percent;
  }
}
