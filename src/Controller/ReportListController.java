package Controller;

import Dao.ReportDao;
import Vo.Paging;
import Vo.Report;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet(name="reportList", urlPatterns = {"/reportList"})
public class ReportListController extends HttpServlet{
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        ReportDao dao = ReportDao.getInstance();
        int page = 1;
        if(req.getParameter("page")!=null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        Paging paging = new Paging();
        int count = dao.getAllCount();
        paging.setTotalCount(count);
        paging.setPage(page);


        ArrayList<Report> list = dao.selectAllMember(paging);
        req.setAttribute("reportList", list);
        req.setAttribute("paging", paging);

        res.setContentType("text/html; charset=EUC-KR");
        req.setCharacterEncoding("EUC-KR");
        RequestDispatcher dispatcher = req.getRequestDispatcher("Admin_reportList.jsp");
        dispatcher.forward(req, res);
    }
}

