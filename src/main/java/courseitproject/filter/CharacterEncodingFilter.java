package courseitproject.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Global filter that ensures UTF-8 encoding for all requests and responses.
 * This prevents Vietnamese text corruption (e.g., "YÊU CẦU" → "YÊU C?U")
 * by setting the character encoding BEFORE any parameter parsing occurs.
 */
@WebFilter(filterName = "CharacterEncodingFilter", urlPatterns = {"/*"})
public class CharacterEncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Set request encoding BEFORE any getParameter() call
        // This is critical: once getParameter() is called, encoding cannot be changed
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding("UTF-8");
        }

        // Set response encoding and content type
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}
