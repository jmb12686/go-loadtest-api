package main

import (
	"fmt"
	"html"
	"log"
	"math/big"
	"net/http"
	"strconv"
	"time"

	"github.com/gorilla/mux"
)

// our main function
func main() {
	router := mux.NewRouter()
	router.HandleFunc("/hello", Hello).Methods("GET")
	router.HandleFunc("/loadtest/iterations/{iterations}", Loadtest).Methods("GET")
	log.Fatal(http.ListenAndServe(":8000", router))
}

/*
Hello handles request to hello endpoint and formats a http response message
*/
func Hello(w http.ResponseWriter, r *http.Request) {
	log.Println("In Hello endpoint handler function")
	fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))
}

/*
Loadtest generates CPU load by multiplying an integer in a loop
*/
func Loadtest(w http.ResponseWriter, r *http.Request) {
	log.Println("In loadtest handler....")
	vars := mux.Vars(r)
	iterationsStr := vars["iterations"]
	iterations, err := strconv.ParseInt(iterationsStr, 10, 64)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	//TODO: Attempt doing primitive / basic integer multiplication!!!

	factValue := new(big.Int)
	factValue.SetInt64(1)
	start := time.Now()
	for i := int64(0); i < iterations; i++ {
		factValue.Mul(factValue, big.NewInt(i))

	}

	end := time.Now()
	elapsed := end.Sub(start)
	log.Println("Loadtest took ", elapsed, " to perform ", iterations)
	fmt.Fprintln(w, "Loadtest took ", elapsed, " to perform ", iterations)

}
