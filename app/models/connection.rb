class Connection < ActiveRecord::Base

  belongs_to :node1, foreign_key: :node_id1, class_name: 'Node'
  belongs_to :node2, foreign_key: :node_id2, class_name: 'Node'

  def self.create_edges(nodes)
    #Generate Edges
    edges=[]
    nodes.each do |node|
      nodes.each do |node2|
        if node.id != node2.id
          edges << Connection.new({
              node1: node,
              node2: node2
          })
        end
      end
    end
    #Order Edges
    edges.sort! {|x,y| x.length<=>y.length }

    #Add Edges
    added=[]
    i = 0
    edges.each do |edge|
      unless edge.is_in added
        added << edge
      end
      i += 1
      logger.debug "#{i} of #{edges.size} done"
    end

    added.each do |edge|
      edge.save
    end
  end

    def length
      Math.sqrt((node1.fx-node2.fx)**2+(node1.fy-node2.fy)**2)
    end


    def is_in(added)
      added.each do |edge|
        if node1.id == edge.node2.id && node2.id == edge.node1.id
          return true
        end
      end

      added.each do |edge|
        if self.has_intersection edge
          return true
        end
      end
      false
    end

    def has_intersection(edge)
      a0=NVector[self.node1.fx,self.node1.fy.to_f]
      a1=NVector[self.node2.fx,self.node2.fy.to_f]
      a2=NVector[edge.node1.fx,edge.node1.fy.to_f]
      a3=NVector[edge.node2.fx,edge.node2.fy.to_f]

      v1=a1-a0
      v2=a3-a2

      a=NMatrix[[v1[0],-v2[0]],[v1[1],-v2[1]]]
      b=NMatrix[[-a0[0]+a2[0]],[-a0[1]+a2[1]]]
      x=a.lu.solve(b)

      if x[0]<1.0 and x[1]<1.0 and x[1]>0.0 and x[0]>0.0
        return true
      end
      false
    end

    end