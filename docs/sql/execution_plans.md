# Using Execution Plans

This is non-exhaustive documentation that should be useful even in Postgres-land but I am specifically writing about SQL Server. Please reach out to the DBA team for more in-depth explanations.

Below is a series of steps you can take to understand and improve query performance by analyzing execution plans.

## Step 1: Retrieve the Execution Plan

To obtain the execution plan for a query, you typically need to use a database-specific command or tool. Retrieving the execution plan allows you to analyze how the database management system (RDBMS) plans to execute the query. Here's how you can retrieve the execution plan:

### 1. From SQL Server Management Studio

To retrieve the execution plan from SQL Server Management Studio, follow these steps:

1. Connect to a SQL Server instance.

2. In the query editor, enter the query for which you want to retrieve the execution plan.

3. Click **Query > Include Actual Execution Plan**. Alternatively, you can use the `Ctrl + M` shortcut.  
i. You can get the **Estimated Execution Plan** by using the `Ctrl + L` shortcut.

4. The execution plan will be displayed in a separate tab alongside the result set. You can switch to the **Execution Plan** tab to view the graphical representation of the plan and analyze the different operations and their properties.

### 2. From DataGrip

To retrieve the execution plan from **DataGrip**, follow these steps:

1. Same as Step 1 for SSMS.

2. Same as Step 2 for SSMS.

3. Right-click the query and select **Explain Plan > Explain Plan**.
i. I prefer **Explain Plan (Raw)** as you can easily copy and paste this into a text editor.

4. You should see the execution plan in the result pane.

## Step 2: Understand the Plan Structure

The execution plan is typically represented as a tree-like structure, where each node represents an operation or step in the query execution. Below are important components to understand from the plan.

1. **Root Node**: The top-level node of the execution plan. It represents the starting point of the query execution and encompasses the entire plan.

2. **Child Nodes**: The operations performed as part of the query execution. They are connected to their parent nodes to indicate the flow of data between operations. Analyze the child nodes to gain insights into the individual steps involved in executing the query.

3. **Order of Operations**: The plan is typically read from top to bottom and left to right. This order indicates the sequence in which the operations are executed.

4. **Parent-Child Relationships**: The connections between parent and child nodes describe the data flow and dependencies between operations. Follow the lines connecting the nodes to understand how data is passed from one operation to another.

5. **Subtrees**: Represent nested operations or subqueries. Pay attention to the boundaries of subtrees and understand the relationships between the main plan and any nested or dependent plans.

## Step 3: Analyze the Node Types

Each node represents an operation or step in the execution plan. 

1. **Scan**: Represents reading data from a table or index. It can be further categorized into:
   - **Table Scan**: Reading all rows from a table. It can be costly for large tables and usually indicates the need for indexes or optimizations.
   - **Index Scan**: Scanning an index to retrieve matching rows. It involves traversing the index structure and fetching the corresponding rows from the table.
   - **Index Seek**: Seeking an index for specific rows based on search criteria. It efficiently finds and retrieves rows that satisfy the search conditions.

2. **Filter**: Filters rows based on specified conditions. It reduces the result set by applying predicates or `WHERE` clauses. The filter condition determines which rows are included in the final output.

3. **Join**: Performs a join operation, combining data from multiple tables based on specified join conditions. Common join types include:
   - **Nested Loop Join**: Iterates through one table (outer) and performs lookups on another table (inner) based on the join conditions. It can be computationally expensive for large tables.
   - **Hash Join**: Creates hash tables to efficiently match rows from different tables. It typically involves building hash tables based on join keys.
   - **Merge Join**: Sorts and merges pre-sorted data from multiple tables. It requires the input data to be sorted based on the join keys.

4. **Sort**: Sorts the rows based on `ORDER BY` clauses (or sorting required for specific join operations like **Merge Join**). Sorting large result sets can be resource-intensive and impact query performance.

5. **Aggregate**: Performs aggregate operations like `SUM()`, `COUNT()`, `AVG()`, etc. It summarizes data based on `GROUP BY` criteria.

6. **Index**: Indicates the use of an index for efficient data retrieval. It may include index scans, seeks, or lookups. Indexes improve query performance by enabling quick data access based on specific columns.

**Note:** Beware of **Join**, **Sort**, and **Aggregate** nodes as they can come with higher costs.

## Step 4: Evaluate the Node Properties

Node properties include information about the estimated or actual cost, the number of rows, the access methods used, etc.

1. **Estimated versus Actual**: 
a. Estimated properties are based on the query optimizer's estimates.
b. Actual properties reflect the actual values observed during query execution. 
c. They usually match but not always (stats could be inaccurate for infrequently accessed data).

2. **Cost**: Provides an indication of the relative expense or resource usage for a particular operation. Higher-cost nodes are often candidates for optimization and performance improvement.

3. **Cardinality**: Helps to assess data volume at different stages of query execution. Nodes with significantly different cardinalities than expected may require further investigation to identify potential data skew or estimation issues.

4. **Access Methods**: Indicates the technique used to retrieve data from tables or indexes (table scans, index scans, seeks, etc). This will help you identify suboptimal or inefficient data retrieval techniques.

5. **Predicate**: Specifies the conditions or filters applied to each node. This helps us understand the data filtering process.

6. **Data Distribution**: SQL Server provides properties related to data distribution, such as distribution type, histogram statistics, or cardinality estimation errors. Analyzing these properties helps you assess how SQL Server estimates and handles the distribution of data, which can impact query performance.

## Step 5: Go with the Flow

By following the order of operations, you can identify the logical and physical steps used to process the query.

1. **Root Node**: Start by identifying the root node in the execution plan. As mentioned previously, this is the entry point of the plan.

2. **Child Nodes**: Follow the child nodes connected to the root node. These are individual operations performed to execute the query. Examine their properties to understand the specific steps involved.

3. **Arrows and Lines**: Follow the lines connecting the nodes. They represent the flow of data between the nodes, indicating the direction and sequence of operations. This helps to understand how data is passed from one operation to another.

4. **Dependencies and Order**: Pay attention to dependencies and order of operations. Some nodes may depend on the output of previous nodes, requiring data to flow in a specific sequence. This shows the logical order of execution.

5. **Join Operations**: In particular, focus on join operations. Identify the join nodes in the execution plan and examine the join types, conditions, and access methods used. This is crucial for optimizing queries with multiple tables.

6. **Grouping and Aggregation**: If your query involves grouping and aggregation, follow the flow of these operations. Identify the nodes responsible for grouping and examine the associated aggregation functions. Consider the impact of the grouping on the flow of data and the subsequent aggregations performed.

## Step 6: Identify Performance Issues

By carefully examining the plan, you can pinpoint areas that require optimization or further investigation.

1. **High-Cost Operations**: These are the most resource-intensive steps in the execution plan. They may include expensive joins, sorts, or aggregations. Consider optimizing these operations to improve query performance.

2. **Large Cardinalities**: This indicates a significant number of rows being processed. If these nodes appear in critical paths or frequently executed operations, they might contribute to performance bottlenecks. Analyze whether there are opportunities to reduce the number of rows or improve filtering conditions.

3. **Inefficient Access Types**: Look for access types that may be inefficient, such as full table scans or index scans (with low selectivity). These operations may result in scanning large data sets, leading to suboptimal performance. Consider optimizing access paths by introducing indexes, reordering joins, etc.

4. **Missing or Ineffective Indexes**: Examine whether the execution plan indicates the use of appropriate indexes. If critical operations lack suitable indexes, it may result in costly full table scans or inefficient joins. Check the production schema to see if indexes are missing from your development schema.

5. **Data Skew**: Uneven data distribution or skew can impact query performance. Identify nodes or operations that involve skewed data, such as joins or groupings. Skew can lead to uneven resource utilization, increased memory requirements, or suboptimal parallelism. You may want to reach out to a DBA. ;)

6. **Unnecessary Sort or Aggregate Operations**: Unnecessary sort or aggregate operations can introduce performance overhead. Determine if these operations are necessary for the query or if they can be eliminated or optimized by adjusting the query logic.

7. **Concurrency Issues**: Always be mindful of potential concurrency issues. Operations involving locks, blocking, or contention can (and will) impact query performance. Consider optimizing isolation levels, transaction boundaries, or revising query execution strategies to minimize concurrency-related performance issues.

8. **Suboptimal Query Constructs**: Assess whether the execution plan reveals suboptimal query constructs, such as redundant subqueries, inefficient joins, or complex expressions. Refactor queries to simplify and optimize the query logic.

## Step 7: Optimize and Iterate

The final step is to optimize the query and iterate on the improvements.

1. **Refactor Queries**: Based on identified performance issues, consider refactoring the queries to eliminate inefficiencies. This may involve revising join conditions, simplifying expressions, removing redundant subqueries, or restructuring the query logic.

2. **Review Indexing Strategy**: Identify missing indexes or ineffective indexes that impact query performance. Introduce new indexes (mindfully) or modify existing ones based on the access patterns and filtering conditions.

3. **Update Statistics**: Talk to the DBA team and ensure that we have accurate and up-to-date statistics. They are used by the query optimizer to make informed decisions about the most efficient query execution plans.

4. **Performance Testing and Benchmarking**: After implementing optimizations, perform performance testing and benchmarking to evaluate the impact of the changes. Compare the results against the baseline to assess the effectiveness of the optimizations.

5. **Monitor and Maintain**: Regularly keep track of query performance and identify any new issues or bottlenecks. Once your changes are in production, you should monitor them just like you would any other code you wrote.
