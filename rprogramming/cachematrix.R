# makeCacheMatrix : return a list of functions

# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 1. Get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
        invs <- NULL 
        set <- function(y) {
                x <<- y # global value
                invs <<- NULL # global value
        }
        get <- function() x 
        
        setInvs <- function(solvemat) invs <<- solvemat
        getInvs <- function() invs
        
        list(set = set, get = get,
             setInverse = setInvs,
             getInverse = getInvs)
}

funs <- makeCacheMatrix()
funs$set(matrix(c(1,2,3,4), 2))
funs$get()


cacheSolve <- function(x, ...) {
        invs <- x$getInverse()  
        if(!is.null(invs)) { # is.null() : ifelse null value exist, TRUE, FALSE) 
                message("getting cached data")
                return(invs)
        }
        data <- x$get()
        invs <- solve(data)
        x$setInverse(invs)
        invs
}
cacheSolve(funs)

