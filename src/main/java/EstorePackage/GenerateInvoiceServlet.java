package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/GenerateInvoiceServlet")
public class GenerateInvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Stub: generate PDF (can use iText or similar here)
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=invoice.pdf");

        ServletOutputStream out = response.getOutputStream();
        out.write(("Invoice PDF content goes here...").getBytes());
        out.flush();
        out.close();
    }
}
