Example using Media Source Extensions to play fragmented MP4 file,
and decrypting using Encrypted Media Extensions API with ClearKey encryption.

* index.html：模拟内容服务商视频播放网页，获取 EME 通信模块（本例中 eme.js），通过调用 MSE 模块（本例中 mse.js） 逐块加载视频片段并控制播放。
* resources.js：模拟 License（Key） server，与 CDM 模块交互并提供解密媒体资源所需的 key；
* media：模拟Key System 和 Packaging service。主要功能是提供一种内容保护（DRM）机制，实际应用中常见的 Key System 有 Clear Key、Playready、Widevine 等；另外，作为 Packaging Service，提供编码并加密媒体资源以供发布和播放使用。
* eme.js：模拟 EME (加密媒体扩展) 通信模块。主要包括监听 MediaKeys 的 message 和 keystatuseschange 变化；发起证书请求；最后，通过 License（key） 解密 video/audio 流；
* mse.js：模拟 MSE (媒体源扩展) 模块，通过调用浏览器提供的 MSE API，来控制视频流播放逻辑。

* MediaSource readyState 属性
  * closed 当前 ms 并未绑定到一个媒体元素上
  * open 当前 ms 已绑定到一个媒体元素, 并准备好接收接收 SourceBuffer 对象
  * ended 当前 ms 已绑定到一个媒体元素, 但流已经被 MediaSource.endOfStream()
* MediaSource 对象事件
  * sourceclosed ms 对象未绑定到媒体元素时
  * sourceopen ms 对象已经绑定到媒体元素, 且准备好添加缓冲区时 (此时 ms.readyState 属open)
  * sourceended 所有数据接收完成后触发
* SourceBuffer 对象事件
  * updatestart sb 对象的 updating 属性从 false 变更为 true 时触发
  * update sb.appendBuffer/remove 方法完成时, 且 updating 已从 true 变更为 se 时触发, 在 updateend 事件之前执行
  * updateend sb.appendBuffer/remove 方法结束时, 且在 update 事件触发后再触发

参考阅读 https://github.com/dt-fe/weekly - https://github.com/dt-fe/weekly/issues/37
