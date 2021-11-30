package vo;

public class Report {
    int reportId;
    String description;
    String uid;
    String adid;
    int itid;
    String datetime;
    String itname;

    public String getItname() {
        return itname;
    }

    public void setItname(String itname) {
        this.itname = itname;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getAdid() {
        return adid;
    }

    public void setAdid(String adid) {
        this.adid = adid;
    }

    public int getItid() {
        return itid;
    }

    public void setItid(int itid) {
        this.itid = itid;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }
}
