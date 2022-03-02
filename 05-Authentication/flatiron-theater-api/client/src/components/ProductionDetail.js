import { useParams } from "react-router-dom";
import {useEffect, useState} from 'react'
function ProductionDetail({cart, setCart}) {
const [production, setProduction] = useState({crew_members:[], performers_and_roles:[]})
  const params = useParams();
  useEffect(()=>{
    fetch(`/productions/${params.id}`)
    .then(res => res.json())
    .then(data => {
      console.log(data)
      setProduction(data)
    })
  },[])
  
 

    const {title, budget, genre, image,description, crew_members, performers_and_roles} = production
    return (
      <div className="card" >
      <h1>{title}</h1>
       <h3>{genre}</h3>
       <h3>{budget}</h3>
       <img style={{width:'100px'}} src={image}/>
       <p>{description}</p>
       <button >Buy Ticket</button>
      </div>
    );
  }
  
  export default ProductionDetail;