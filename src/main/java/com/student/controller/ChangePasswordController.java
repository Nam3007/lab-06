/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.student.controller;
import com.student.dao.UserDAO;
import com.student.model.User;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.io.IOException;
/**
 *
 * @author admin
 */
@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet{
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user")== null){
            response.sendRedirect("login");
            return;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/change-password.jsp");
        dispatcher.forward(request, response);

    }
    @Override
    protected void doPost(HttpServletRequest request , HttpServletResponse response)
            throws ServletException,IOException{
       // TODO: Get current user from session
       HttpSession session = request.getSession(false);
         if(session == null || session.getAttribute("user")== null){
              response.sendRedirect("login");
              return;
         }
            User user = (User) session.getAttribute("user");

        // TODO: Get form parameters (currentPassword, newPassword, confirmPassword)
         String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // TODO: Validate current password
        User authenticateUser = userDAO.authenticate(user.getUsername(), currentPassword);
        if(authenticateUser == null){ 
            request.setAttribute("errorCurrentPassword"," Current password is incorrect");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        // TODO: Validate new password (length, match)
        if(newPassword == null || newPassword.length()< 8){
            request.setAttribute("errorNewPassword"," New password must be at least 8 characters long");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("errorConfirmPassword"," New password and confirm password do not match");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        // TODO: Hash new password
        String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // TODO: Update in database
        boolean updateSuccess = userDAO.changePassword(user.getId(), hashedNewPassword);
        
        // TODO: Show success/error message
        if(!updateSuccess){
            response.sendRedirect("change-password?error=Failed to change password");
            return;
        }
        
        response.sendRedirect("change-password?message=Password changed successfully");
    
    
    }
    
    
}

