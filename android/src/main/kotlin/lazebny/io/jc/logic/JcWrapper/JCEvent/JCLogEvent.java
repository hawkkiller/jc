package lazebny.io.jc.logic.JcWrapper.JCEvent;

public class JCLogEvent extends JCEvent {

    public String log;

    public JCLogEvent(String log) {
        super(EventType.JCLOG);
        this.log = log;
    }
}
