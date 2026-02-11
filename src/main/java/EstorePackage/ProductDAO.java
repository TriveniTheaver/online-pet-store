package EstorePackage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import UserPackage.DBconnection;

public class ProductDAO {
	//connect db
	private static boolean isSuccess;
	private static Connection con=null;
	private static Statement stmt=null;
	private static ResultSet rs=null;
	
	// crud
	
	//insert data function
	public static boolean insertdata (String name,String price, String category,int quantity,String description,String imageUrl) {
		boolean isSuccess=false;
		try {
			//gets db connection
			con=DBconnection.getConnection();
			stmt=con.createStatement();
			
			//sql insert query
			String sql="insert into product values(0,'"+name+"','"+price+"','"+category+"','"+quantity+"','"+description+"','"+imageUrl+"')";
			
			//execute insertion-add new tow to the table
			int rs = stmt.executeUpdate(sql);
			
			//check if insert is successful
			if(rs>0) {
				isSuccess=true;
			}
			else {
				isSuccess=false;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
		
	}
	
	

	
	//get or read all data
	public static List<ProductModel> getAllProduct(){
		ArrayList <ProductModel> products=new ArrayList<>();
		try {
			//DBConnection
			con=DBconnection.getConnection();
			stmt=con.createStatement();
			
			//query
			String sql="select * from product";
			rs=stmt.executeQuery(sql);
			
			while (rs.next()) {
				int id=rs.getInt(1);
				String name=rs.getString(2);
				String price=rs.getString(3);
				String category=rs.getString(4);
				int quantity=rs.getInt(5);
				String description=rs.getString(6);
				String imageUrl = rs.getString(7);
				
				ProductModel pt= new ProductModel(id,name,price,category,quantity,description,imageUrl);
				products.add(pt);
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return products;
	}
	
	//update data
	public static boolean updateData(int id,String name,String price,String category,int quantity,String description,String imageUrl){
		try {
			//DBConnection
			con=DBconnection.getConnection();
			stmt=con.createStatement();
			
			//sql query
			String sql="update product set name='"+name+"',price='"+price+"',category='"+category+"',quantity='"+quantity+"',description='"+description+"',imageUrl='"+imageUrl+"'"
					+" where id='"+id+"'";
			int rs=stmt.executeUpdate(sql);
			if(rs>0) {
				isSuccess=true;
			}
			else {
				isSuccess=false;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	
	//delete data
		public static boolean deleteData(String id){
			int convID=Integer.parseInt(id);
			try {
				//DBConnection
				con=DBconnection.getConnection();
				stmt=con.createStatement();
				
				//sql query
				String sql="delete from product where id='"+convID+"'";
				
				int rs=stmt.executeUpdate(sql);
				if(rs>0) {
					isSuccess=true;
				}
				else {
					isSuccess=false;
				}
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return isSuccess;
		}
		
		//helper method to find total product count
		 public int getTotalProductCount() {
		        int count = 0;
		        try {
		            con = DBconnection.getConnection();
		            stmt = con.createStatement();
		            
		            String sql = "SELECT COUNT(*) FROM product";
		            rs = stmt.executeQuery(sql);
		            
		            if (rs.next()) {
		                count = rs.getInt(1);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return count;
		    }
		 
		//helper method to find total ou of stock product count  
		    public int getOutOfStockCount() {
		        int count = 0;
		        try {
		            con = DBconnection.getConnection();
		            stmt = con.createStatement();
		            
		            String sql = "SELECT COUNT(*) FROM product WHERE quantity <= 0";
		            rs = stmt.executeQuery(sql);
		            
		            if (rs.next()) {
		                count = rs.getInt(1);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return count;
		    }
		    
		  //helper method to find total low stock product count
		    public int getLowStockCount(int threshold) {
		        int count = 0;
		        try {
		            con = DBconnection.getConnection();
		            stmt = con.createStatement();
		            
		            String sql = "SELECT COUNT(*) FROM product WHERE quantity > 0 AND quantity <= " + threshold;
		            rs = stmt.executeQuery(sql);
		            
		            if (rs.next()) {
		                count = rs.getInt(1);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return count;
		    }
		    //display out of stock products
		    public List<ProductModel> getOutOfStockProducts() {
		        ArrayList<ProductModel> products = new ArrayList<>();
		        try {
		            con = DBconnection.getConnection();
		            stmt = con.createStatement();
		            
		            String sql = "SELECT * FROM product WHERE quantity <= 0";
		            rs = stmt.executeQuery(sql);
		            
		            while (rs.next()) {
		                int id = rs.getInt(1);
		                String name = rs.getString(2);
		                String price = rs.getString(3);
		                String category = rs.getString(4);
		                int quantity = rs.getInt(5);
		                String description = rs.getString(6);
		                String imageUrl = rs.getString(7);
		                
		                ProductModel pt = new ProductModel(id, name, price, category, quantity, description, imageUrl);
		                products.add(pt);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return products;
		    }
		  //display low of stock products

		    public List<ProductModel> getLowStockProducts(int threshold) {
		        ArrayList<ProductModel> products = new ArrayList<>();
		        try {
		            con = DBconnection.getConnection();
		            stmt = con.createStatement();
		            
		            String sql = "SELECT * FROM product WHERE quantity > 0 AND quantity <= " + threshold;
		            rs = stmt.executeQuery(sql);
		            
		            while (rs.next()) {
		                int id = rs.getInt(1);
		                String name = rs.getString(2);
		                String price = rs.getString(3);
		                String category = rs.getString(4);
		                int quantity = rs.getInt(5);
		                String description = rs.getString(6);
		                String imageUrl = rs.getString(7);
		                
		                ProductModel pt = new ProductModel(id, name, price, category, quantity, description, imageUrl);
		                products.add(pt);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return products;
		    }
		    
		    
		
		    
		    
		    
		    
		
		//get by id function
		public static List<ProductModel> getById(int id) {
		    ArrayList<ProductModel> product = new ArrayList<>();
		    
		    try {
		        // DB connection
		        con = DBconnection.getConnection();
		        stmt = con.createStatement();
		        
		        //  SQL query
		        String sql = "SELECT * FROM product WHERE id = " + id;
		        rs = stmt.executeQuery(sql);
		        
		        while (rs.next()) {
		            int productId = rs.getInt(1);  
		            String name = rs.getString(2);
		            String price = rs.getString(3);
		            String category = rs.getString(4);
		            int quantity = rs.getInt(5);
		            String description = rs.getString(6);
		            String imageUrl = rs.getString(7);
		            
		            ProductModel pt = new ProductModel(productId, name, price, category, quantity, description, imageUrl);
		            product.add(pt);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    
		    return product;
		}
		
	//show data in shop page
		public static List<ProductModel> DisplayAllProduct() {
		    ArrayList<ProductModel> products = new ArrayList<>();
		    try {
		        con = DBconnection.getConnection();
		        stmt = con.createStatement();
		        
		        String sql = "SELECT * FROM product";
		        rs = stmt.executeQuery(sql);
		        
		        while (rs.next()) {
		            int id = rs.getInt(1);
		            String name = rs.getString(2);
		            String price = rs.getString(3);
		            String category = rs.getString(4);
		            int quantity = rs.getInt(5);
		            String description = rs.getString(6);
		            String imageUrl = rs.getString(7);
		            
		            ProductModel pt = new ProductModel(id, name, price, category, quantity, description, imageUrl);
		            products.add(pt);
		            
		            // Debugging: Print retrieved data
		            System.out.println("Product Found: " + name + " - " + price);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return products;
		}
		
		
		 // Update stock quantity
	    public static boolean updateStock(int id, int newQuantity) {
	        boolean isSuccess = false;
	        try {
	            Connection con = DBconnection.getConnection();
	            Statement stmt = con.createStatement();

	            String sql = "UPDATE product SET quantity = " + newQuantity + " WHERE id = " + id;
	            int rs = stmt.executeUpdate(sql);

	            if (rs > 0) {
	                isSuccess = true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return isSuccess;
	    }
	    
	   
	   
	    
}
