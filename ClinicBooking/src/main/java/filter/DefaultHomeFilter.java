/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Default Home Filter - Redirects root requests to /home
 *
 * @author Le Anh Tuan - CE180905
 */
public class DefaultHomeFilter implements Filter {

    /**
     * Filters requests and redirects root URL to /home
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Check if the request is for the root path
        if (requestURI.equals(contextPath + "/") || requestURI.equals(contextPath)) {
            // Redirect to /home
            httpResponse.sendRedirect(contextPath + "/home");
            return;
        }

        // Continue with the filter chain for other requests
        chain.doFilter(request, response);
    }

    /**
     * Init method for this filter
     */
    @Override
    public void init(FilterConfig filterConfig) {
        // Initialization code if needed
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
