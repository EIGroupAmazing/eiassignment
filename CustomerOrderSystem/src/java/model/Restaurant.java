package model;


import model.Pkg;
import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Alex
 */
public class Restaurant {
    private String name;
    private ArrayList<Pkg> pkgList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Pkg> getPkgList() {
        return pkgList;
    }

    public void setPkgList(ArrayList<Pkg> pkgList) {
        this.pkgList = pkgList;
    }
    public void addPkg(Pkg pkg){
        this.pkgList.add(pkg);
    }

    
}
