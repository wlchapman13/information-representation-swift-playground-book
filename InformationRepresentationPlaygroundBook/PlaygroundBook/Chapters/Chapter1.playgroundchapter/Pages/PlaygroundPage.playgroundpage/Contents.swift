//#-hidden-code
import PlaygroundSupport
//#-end-hidden-code
let str = "Hello, playground"
print("The contents of str is \(str)")

//#-editable-code




//#-end-editable-code

//#-hidden-code
//  send the entire contents of the user-provided swift code to the live view
//  (i.e., PlaygroundPage.current.text)
let page = PlaygroundPage.current
if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
    let proxyMessage = PlaygroundValue.string(PlaygroundPage.current.text)
    proxy.send(proxyMessage)
    print("Sent: " + PlaygroundPage.current.text)
}
//#-end-hidden-code

