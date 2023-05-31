package lazebny.io.jc.logic

import com.juphoon.cloud.JCClient
import lazebny.io.jc.common.JcClientStateApi
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcClientStateApiImpl : JcClientStateApi {
    override fun getClientState(): Int {
        /*
        public static final int STATE_NOT_INIT = 0;
        public static final int STATE_IDLE = 1;
        public static final int STATE_LOGINING = 2;
        public static final int STATE_LOGINED = 3;
        public static final int STATE_LOGOUTING = 4;
        */
        return JCManager.getInstance().client.state
    }
}