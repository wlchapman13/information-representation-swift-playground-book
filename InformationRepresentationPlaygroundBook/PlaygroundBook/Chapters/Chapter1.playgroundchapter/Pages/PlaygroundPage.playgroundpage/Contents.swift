//#-hidden-code
import PlaygroundSupport
//#-end-hidden-code
/*:
 
 # Information Representation
 
 While computers can sometimes seem magical, they are just machines.
 
 When we tell the computer we would like it to store some information, for example in a constant or a variable, the machine has to have a way to store this information.
 
 In many computers today, this information is stored as a sequence of switches, each swith is either off or on.  The configuration of the pattern of the on-off sequence is the representation of the information.  A machine doesn't have to use switches, however.  It could be a sequence of balls or marbles in a wooden computer like this one:  https://youtu.be/GcDshWmhF4A
 
 In our machine on the right, we are using a set of 8 lights to represent the information that you request in your program.  When you enter a declaration and assignments for a constant or variable in your program on the left, the machine compiles your code and determines which bank of eight lights it will use to store that information.  Then when the value is assigned to it, the machine will turn on the correct sequence of lights to represent your data.
 
 --------------------------------------------------------
 
 Try it out yourself.  In the code box below, enter a set of Swift statements to declare and initialize some values.  For example, you might try the following:
 
    let numberOfItems = 11
    var cost = 12.99
    var product = "oz"
 
 Watch carefully to see what the computer does with the string "oz".  How does it represent that String?
 
 */
//#-editable-code
// Add your code here

//#-end-editable-code

/*:
 Tap the "Run My Code" button to see how your information is stored in this machine.
 */


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

