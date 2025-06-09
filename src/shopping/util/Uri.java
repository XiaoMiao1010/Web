package shopping.util;

import javax.servlet.http.HttpServletRequest;

public class Uri {
    public static String geturi(HttpServletRequest req) {
        String uri = req.getRequestURI();
        String suffix = uri.substring(uri.lastIndexOf("/") + 1);
        return suffix;
    }
}
