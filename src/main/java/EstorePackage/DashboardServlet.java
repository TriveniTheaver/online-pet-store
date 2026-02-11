package EstorePackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	
    	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	    
    	    
    	    //debugging
    	    try (Connection testCon = DBconnection.getConnection()) {
    	        System.out.println("Connection test successful!");
    	    } catch (SQLException e) {
    	        System.out.println("Connection failed: " + e.getMessage());
    	        e.printStackTrace();
    	    }

    	    try {
    	        System.out.println("Fetching dashboard data...");
    	       // int monthlySales = DashboardDBUtil.getMonthlySalesCount();
    	        int userCount = DashboardDBUtil.getUserCount();
    	        int employeeCount = DashboardDBUtil.getEmployeeCount();
    	        int pendingOrders = DashboardDBUtil.getPendingOrdersCount();
    	        int openQueries = DashboardDBUtil.getOpenQueriesCount();
    	        double todaysSales = DashboardDBUtil.getTodaysTotalSales();
                double monthlySales = DashboardDBUtil.getMonthlySalesTotal();
    	        
    	        
    	       // req.setAttribute("monthlySales", monthlySales);
    	        req.setAttribute("userCount", userCount);
    	        req.setAttribute("employeeCount", employeeCount);
    	        req.setAttribute("pendingOrdersCount", pendingOrders);
    	        req.setAttribute("openQueriesCount", openQueries);
    	        req.setAttribute("todaysSales", String.format("%.2f", todaysSales));
                req.setAttribute("monthlySales", String.format("%.2f", monthlySales));

    	        System.out.println("Attributes set, forwarding to JSP...");
    	        req.getRequestDispatcher("admindashboard.jsp").forward(req, res);
    	        
    	    } catch (Exception e) {
    	        System.out.println("Error in DashboardServlet:");
    	        e.printStackTrace();
    	        req.setAttribute("errorMessage", "Error: " + e.getMessage());
    	        req.getRequestDispatcher("error.jsp").forward(req, res);
    	    }
    	    
    	}  
    	          
    	   
    	


    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        doGet(req, res);
    }
}
