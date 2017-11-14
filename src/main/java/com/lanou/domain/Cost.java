package com.lanou.domain;

import java.util.Date;

/**
 * Created by dllo on 17/11/11.
 */
public class Cost {

    private int COST_ID;
    private String NAME;
    private int BASE_DURATION;
    private int BASE_COST;
    private int UNIT_COST;
    private String STATUS;
    private String DESCR;
    private Date CREATIME;
    private Date STARTIME;
    private String COST_TYPE;

    public Cost() {
    }

    public Cost(int COST_ID, String NAME, int BASE_DURATION, int BASE_COST,
                int UNIT_COST, String STATUS, String DESCR, Date CREATIME, Date STARTIME,
                String COST_TYPE) {
        this.COST_ID = COST_ID;
        this.NAME = NAME;
        this.BASE_DURATION = BASE_DURATION;
        this.BASE_COST = BASE_COST;
        this.UNIT_COST = UNIT_COST;
        this.STATUS = STATUS;
        this.DESCR = DESCR;
        this.CREATIME = CREATIME;
        this.STARTIME = STARTIME;
        this.COST_TYPE = COST_TYPE;
    }

    @Override
    public String toString() {
        return "Cost{" +
                "COST_ID=" + COST_ID +
                ", NAME='" + NAME + '\'' +
                ", BASE_DURATION=" + BASE_DURATION +
                ", BASE_COST=" + BASE_COST +
                ", UNIT_COST=" + UNIT_COST +
                ", STATUS=" + STATUS +
                ", DESCR='" + DESCR + '\'' +
                ", CREATIME=" + CREATIME +
                ", STARTIME=" + STARTIME +
                ", COST_TYPE='" + COST_TYPE + '\'' +
                '}';
    }

    public int getCOST_ID() {
        return COST_ID;
    }

    public void setCOST_ID(int COST_ID) {
        this.COST_ID = COST_ID;
    }

    public String getNAME() {
        return NAME;
    }

    public void setNAME(String NAME) {
        this.NAME = NAME;
    }

    public int getBASE_DURATION() {
        return BASE_DURATION;
    }

    public void setBASE_DURATION(int BASE_DURATION) {
        this.BASE_DURATION = BASE_DURATION;
    }

    public int getBASE_COST() {
        return BASE_COST;
    }

    public void setBASE_COST(int BASE_COST) {
        this.BASE_COST = BASE_COST;
    }

    public int getUNIT_COST() {
        return UNIT_COST;
    }

    public void setUNIT_COST(int UNIT_COST) {
        this.UNIT_COST = UNIT_COST;
    }

    public String getSTATUS() {
        return STATUS;
    }

    public void setSTATUS(String STATUS) {
        this.STATUS = STATUS;
    }

    public String getDESCR() {
        return DESCR;
    }

    public void setDESCR(String DESCR) {
        this.DESCR = DESCR;
    }

    public Date getCREATIME() {
        return CREATIME;
    }

    public void setCREATIME(Date CREATIME) {
        this.CREATIME = CREATIME;
    }

    public Date getSTARTIME() {
        return STARTIME;
    }

    public void setSTARTIME(Date STTARTIME) {
        this.STARTIME = STARTIME;
    }

    public String getCOST_TYPE() {
        return COST_TYPE;
    }

    public void setCOST_TYPE(String COST_TYPE) {
        this.COST_TYPE = COST_TYPE;
    }
}
