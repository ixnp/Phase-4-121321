import { Route, Switch } from "react-router-dom";
import styled from "styled-components";

import {useEffect, useState} from 'react'
import ProductionContainer from './components/ProductionContainer'
import ProductionForm from './components/ProductionForm'
import Navigation from './components/Navigation'
import ProductionDetail from './components/ProductionDetail'
import Auth from './components/Auth'
import Login from './components/LogIn'

function App() {
  const [productions, setProductions] = useState([])
  const [errors, setErrors] = useState(false)
  const [cart, setCart] = useState([])

  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [user, setUser] = useState(null);


  useEffect(() => {
    fetch("/authorized_user")
    .then((res) => {
      if (res.ok) {
        res.json()
        .then((user) => {
          setIsAuthenticated(true);
          setUser(user);
        });
      }
    });

    fetch('/productions')
    .then(res => res.json())
    .then(setProductions)
  },[])

  function handlePost(obj){
      fetch('/productions',{
        method:'POST',
        headers: {'Content-Type': 'application/json'},
        body:JSON.stringify(obj)
      })
      .then(res => res.json())
      .then(data => {
        console.log(data)
        if(data.errors){
          setErrors(data.errors)
        } else {
          setProductions([...productions,data])
        }
      })
  }

  return (
    <>
    <Navigation cart={cart} user={user} setIsAuthenticated={setIsAuthenticated} setUser={setUser}/>
    { (!isAuthenticated)? <Login error={'please login'} setIsAuthenticated={setIsAuthenticated} setUser={setUser} />:

    <Switch>
    <Route exact path="/">
      <ProductionContainer productions={productions}/>
    </Route>
    <Route exact path="/productions/new">
      <ProductionForm handlePost={handlePost} errors={errors} />
    </Route>
    <Route exact path="/productions/:id">
        <ProductionDetail cart={cart} setCart={setCart}/>
    </Route>
    <Route path="/sign_up">
          <Auth setIsAuthenticated={setIsAuthenticated} setUser={setUser} />
    </Route>
    <Route path="/login">
          <Login  error={'please login'} setIsAuthenticated={setIsAuthenticated} setUser={setUser} />
    </Route>
    </Switch>
}
    </>
  );
}

export default App;

const Body = styled.body`
  background-color:black;
`