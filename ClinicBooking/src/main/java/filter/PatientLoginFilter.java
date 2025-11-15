/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.PatientDTO;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PatientLoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) sr;
        HttpServletResponse httpResponse = (HttpServletResponse) sr1;

        PatientDTO patient = (PatientDTO) httpRequest.getSession().getAttribute("patient");

        if (patient != null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/patient-login");
            return;
        }

        // Continue with the filter chain for other requests
        fc.doFilter(sr, sr1);
    }

    @Override
    public void destroy() {

    }

}
