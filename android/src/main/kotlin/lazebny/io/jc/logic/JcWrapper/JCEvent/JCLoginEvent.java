package lazebny.io.jc.logic.JcWrapper.JCEvent;

import com.juphoon.cloud.JCClient;

public class JCLoginEvent extends JCEvent {

    public boolean result;
    @JCClient.ClientReason
    public int reason;

    public JCLoginEvent(boolean result, @JCClient.ClientReason int reason) {
        super(EventType.LOGIN);
        this.result = result;
        this.reason = reason;
    }

}
