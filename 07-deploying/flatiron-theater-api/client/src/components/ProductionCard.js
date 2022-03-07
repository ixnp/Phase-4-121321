import {Link} from "react-router-dom";

function ProductionCard({production}) {
    const {title, budget, genre, image, id} = production
    console.log(production)
    return (
      <Link to={`/productions/${id}`}>
      <tr className="table-row" >
       <td>{title}</td>
       <td>{genre}</td>
       <td>$ {budget}</td>
       <td><img style={{width:'100px'}} src={image}/></td>
      </tr>
      </Link>
    );
  }
  
  export default ProductionCard;