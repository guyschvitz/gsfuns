##' View tables in Postgresql database
##'
##'
##' @param conn a DBIConnection object, as returned by \code{DBI::dbConnect()}
##' @param table Regular expression for table name (optional, case insensitive)
##' @param schema Regular expression for schema name (optional, case insensitive)
##'
##' @return data.frame listing name and schema of all tables that match query
##'

viewPgTables <- function(conn, table=NULL, schema = NULL){
  ## conn: DBI / RPostgreSQL connection object
  ## table: Regular expression for table
  ## schema: Regular expression for schema

  ## First part of query
  sql1 <- "SELECT DISTINCT table_schema, table_name FROM information_schema.columns "
  ## Middle part 1 (optional)
  sql2 <- ifelse(is.null(table), "", paste0("table_name ILIKE '%", table, "%' "))
  ## Middle part 2 (optional)
  sql3 <- ifelse(is.null(schema), "", paste0("table_schema ILIKE '%", schema, "%' "))
  ## Last part of query
  sql4 <- "ORDER BY table_schema, table_name;"

  if(is.null(table) & is.null(schema)){
    sql <- paste0(sql1, sql4)
    msg <- "Showing all tables in database."
  } else if(is.null(table) & !is.null(schema)){
    sql <- paste0(sql1, "WHERE ", sql3, sql4)
    msg <- paste0("Showing all tables in schema matching '%", schema, "%'")
  } else if(!is.null(table) & is.null(schema)){
    sql <- paste0(sql1, "WHERE ", sql2, sql4)
    msg <- paste0("Showing all tables matching '%", table, "%'")
  } else if(!is.null(table) & !is.null(schema)){
    sql <- paste0(sql1, "WHERE ", sql2, "AND ", sql3, sql4)
    msg <- paste0("Showing tables matching '%", table,
                  "%' in schemas matching '%", schema, "'%")
  }
  message(msg)
  return(dbGetQuery(conn, statement = sql))
}
