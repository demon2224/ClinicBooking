/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.phamacist;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class PharmacistManagePrescriptionController extends HttpServlet {

    @Override
    public void init() throws ServletException {
    }
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagePrescriptionController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagePrescriptionController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);

        String action = request.getParameter("action");

         try {
            switch (action) {

                // If the action is detail then show the user the detail of specific medicine.
                case "detail":
//                    handleViewMedicineDetailRequest(request, response);
                    break;

                // If the action is search then show the user the list of.all medicine that match with user input.
                case "search":
//                    handleSearchRequest(request, response);
                    break;

                // If the action is create then show the user the view when create new medicine.
                case "create":
//                    handleCreateRequest(request, response);
                    return;

                // If the action is edit then show the user the view when edit a medicine.
                case "edit":
//                    handleEditRequest(request, response);
                    break;

                // If the action is import then show the user the view when import a medicine.
                case "import":
//                    handleImportRequest(request, response);
                    break;

                // If the action is not all of above then show the user the medicine list.
                default:
                    handleInvalidRequest(request, response);
                    break;
            }
        } catch (ServletException | IOException | NullPointerException e) {
            // If an exception occur then show the user the medicine list.
            handleInvalidRequest(request, response);
        }
    }
    
    private void handleInvalidRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/pharmacist/MedicineList.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);

        response.sendRedirect(request.getContextPath() + "/pharmacist-manage-prescription");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
